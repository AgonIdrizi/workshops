# Copyright (c) 2016 Banff International Research Station.
# This file is part of Workshops. Workshops is licensed under
# the GNU Affero General Public License as published by the
# Free Software Foundation, version 3 of the License.
# See the COPYRIGHT file for details and exceptions.

class Setting < RailsSettings::Base
  validates :var, uniqueness: true
  before_save :convert_type, :update_locations
  after_update :rewrite_cache
  after_create :rewrite_cache
  namespace Rails.env

  def name(key)
    loc = Setting.find_by_var('Locations').value[key.to_sym]
    loc.nil? ? key : loc['Name']
  end

  def rewrite_cache
    Rails.cache.write("settings:#{self.var}", self.value, expires_in: 10.minutes)
  end

  def update_locations
    if self.var == 'Locations'
      remove_location if self.value.keys.include? 'remove_location'
      add_location if self.value.keys.include? 'new_location'

      settings = self.value.except(:'')
      self.value.each do |key, values|
        new_key = values.delete(:new_key)
        settings[key] = values
        if !new_key.blank? && new_key != key
          settings[:"#{new_key}"] = settings.delete("#{key}")
          update_all_keys(old_key: key, new_key: new_key)
        end
      end
      self.value = settings
    end
  end

  def update_all_keys(old_key:, new_key:)
    (Setting.get_all.keys - ['Site', 'Locations']).each do |section|
      setting = Setting.find_by(var: section)
      setting_value = setting.value
      setting_value[new_key.to_sym] = setting_value.delete(old_key.to_sym)
      setting.value = setting_value
      setting.save!
    end
  end 

  def remove_location
    settings = self.value
    location_key = settings.delete(:remove_location)
    self.value = settings.except(location_key.to_sym)

    unless location_key.empty?
      (Setting.get_all.keys - ['Site', 'Locations']).each do |section|
        setting = Setting.find_by(var: section)
        section_settings = setting.value
        setting.value = section_settings.except(location_key.to_sym)
        setting.save!
      end
    end
  end

  def add_location
    location_value = self.value
    new_location_key = location_value.delete(:new_location)
    self.value = location_value.except(:new_location)
    return true if new_location_key.blank?

    (Setting.get_all.keys - ['Site']).each do |section|
      setting = Setting.find_by(var: section)
      section_settings = setting.value
     
      empty_fields = {}
      unless section_settings.keys.empty?
        section_settings[section_settings.keys.first].each do |key, value|
          empty_fields[:"#{key}"] = ''
        end
      end
      new_location = {:"#{new_location_key}" => empty_fields}

      new_value = section_settings.merge(new_location)
      if section == 'Locations'
        self.value = new_value
      else
        setting.value = new_value
        setting.save!
      end
    end
  end

  # Save arrays as arrays (not strings)
  def convert_type
    self.value.each do |param_name, param_value|
      if param_value =~ /^\[(.+)\]$/
        param_value = param_value.gsub(/^\[|"|'|\]$/, '').split(',').map(&:strip)
        self.value = self.value.merge("#{param_name}": param_value)
      end
    end
  end

end