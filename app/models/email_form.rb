# app/models/email_form.rb
#
# Copyright (c) 2019 Banff International Research Station.
# This file is part of Workshops. Workshops is licensed under
# the GNU Affero General Public License as published by the
# Free Software Foundation, version 3 of the License.
# See the COPYRIGHT file for details and exceptions.

# Facilitates email change form
class EmailForm < ComplexForms
  attr_accessor :person

  def initialize(person)
    @person = person
  end

  def validate_email(attributes = {})
    submitted_email = attributes['person']['email'].downcase.strip
    @person = SyncPerson.change_email(@person, submitted_email)

    unless @person.valid?
      @person.errors.full_messages.each do |msg|
          errors.add('Error:', msg)
      end
    end

    @person.save! if @person.valid?
  end
end