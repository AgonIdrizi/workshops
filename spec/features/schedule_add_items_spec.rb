# Copyright (c) 2016 Brent Kearney. This file is part of Workshops.
# Workshops is licensed under the GNU Affero General Public License
# as published by the Free Software Foundation, version 3 of the License.
# See the COPYRIGHT file for details and exceptions.

require 'rails_helper'

describe "Adding a Schedule Item", :type => :feature do

  before do
    authenticate_user

    @event = FactoryGirl.create(:event)
    @day = @event.start_date + 3.days
    @weekday = @day.strftime("%A")
    FactoryGirl.create(:schedule, event: @event)

    visit event_schedule_index_path(@event)
  end

  after(:each) do
    Warden.test_reset!
  end


  it 'opens an edit/add form when the "Add an Item" button is clicked' do
    click_link "Add an item on #{@weekday}"
    expect(current_path).to eq(event_schedule_day_path(@event, @day))
  end

  it 'adds an item to the schedule' do
    click_link "Add an item on #{@weekday}"
    page.fill_in 'schedule_name', :with => 'New item for test schedule'
    page.fill_in 'schedule_location', :with => 'Somewhere'
    click_button 'Add New Schedule Item'

    expect(page).to have_content '"New item for test schedule" was successfully scheduled.'
    expect(@event.schedules.select {|s| s.name == 'New item for test schedule'}).not_to be_empty
  end

  it 'sets new schedule item times in the associated event\'s time zone' do
    event = FactoryGirl.create(:event, name: 'TZ Test Event', time_zone: 'Brisbane')
    FactoryGirl.create(:schedule, event: event)
    day = event.start_date + 2.days
    weekday = day.strftime("%A")
    visit event_schedule_index_path(event)

    click_link "Add an item on #{weekday}"
    page.fill_in 'schedule_name', :with => 'Testing TZ'
    page.fill_in 'schedule_location', :with => 'Australia'
    click_button 'Add New Schedule Item'

    new_item = event.schedules.select {|s| s.name == 'Testing TZ'}.first
    expect(new_item.start_time.time_zone.name).to eq(event.time_zone)
    expect(new_item.end_time.time_zone.name).to eq(event.time_zone)
  end

  it 'has a drop-down list of days of the workshop to change to' do
    click_link "Add an item on #{@weekday}"
    expect(page).to have_select(:schedule_day)
  end

  it 'changing the day on the add form schedules the item for the selected day' do
    click_link "Add an item on #{@weekday}"
    new_day = @day + 1.days
    page.select new_day.strftime("%A"), :from => 'schedule_day'
    page.fill_in 'schedule_name', :with => 'Another item for testing'
    page.fill_in 'schedule_location', :with => 'Somewhere'
    click_button 'Add New Schedule Item'
    new_item = @event.schedules.select {|s| s.name == 'Another item for testing'}.first
    expect(new_item.start_time.to_date).to eq(new_day)
  end

  it 'adding an item that overlaps with another item (in a different room) produces a warning notice' do
    click_link "Add an item on #{@weekday}"
    page.fill_in 'schedule_name', :with => 'Item One'
    page.fill_in 'schedule_location', :with => 'Location One'
    page.select '09', :from => 'schedule_start_time_4i'
    page.select '10', :from => 'schedule_end_time_4i'
    click_button 'Add New Schedule Item'

    page.fill_in 'schedule_name', :with => 'Item Two'
    page.fill_in 'schedule_location', :with => 'Location Two'
    page.select '09', :from => 'schedule_start_time_4i'
    page.select '30', :from => 'schedule_start_time_5i'
    page.select '10', :from => 'schedule_end_time_4i'
    page.select '30', :from => 'schedule_end_time_5i'
    click_button 'Add New Schedule Item'

    expect(find("div.alert-warning").text).to match(/^Warning: .+overlaps with.+ \"Item One\"/)
  end

  it 'after adding an item, it returns to the Add Item page for the day of the updated item' do
    click_link "Add an item on #{@weekday}"
    expect(current_path).to eq(event_schedule_day_path(@event, @day))

    page.fill_in 'schedule_name', :with => 'New item for test schedule'
    page.fill_in 'schedule_location', :with => 'Somewhere'
    click_button 'Add New Schedule Item'

    expect(current_path).to eq(event_schedule_day_path(@event, @day))
  end

  context 'Is authorized only for admin users (above), and staff and organizers of the event' do
    before do
      @membership = FactoryGirl.create(:membership, event: @event, person: @person)
    end

    it 'hides "Add an Item" button from users who are not event members' do
      @user.member!
      @membership.destroy
      visit event_schedule_index_path(@event)
      expect(page.body).not_to have_link("Add an item on #{@weekday}")
    end

    it 'only shows "Add an Item" button to members who are event organizers' do
      @user.member!
      Membership::ROLES.each do |role|
        @membership.role = role
        @membership.save
        visit event_schedule_index_path(@event)
        if role =~ /Organizer/
          expect(page.body).to have_link("Add an item on #{@weekday}")
        else
          expect(page.body).not_to have_link("Add an item on #{@weekday}")
        end
      end
    end

    it 'shows "Add an Item" button to staff users at the event location' do
      @user.role = 'staff'
      @user.location = @event.location
      @user.save!

      @membership.role = 'Organizer'
      @membership.save!
      visit event_schedule_index_path(@event)
      expect(page.body).to have_link("Add an item on #{@weekday}")
    end

    it 'does NOT show "Add an Item" button to staff users who are not at the event location' do
      @user.role = 'staff'
      @user.location = 'Somewhere'
      @user.save!
      @membership.destroy

      visit event_schedule_index_path(@event)
      expect(page.body).not_to have_link("Add an item on #{@weekday}")
    end

    it 'does not show Add Item button to non-admin users who are not members of the event' do
      @user.member!
      @membership.destroy
      visit event_schedule_index_path(@event)

      expect(page.body).not_to have_link("Add an item on #{@weekday}")
    end

    it 'denies non-admin users who are not members of the event who try to access the add item path' do
      @user.member!
      @membership.destroy
      visit event_schedule_day_path(@event, @day)
      expect(current_path).not_to eq(event_schedule_day_path(@event, @day))
      expect(page.body).to have_text('Only staff and event organizers may modify the schedule')
    end

    it 'denies non-admin users who are not organizers of the event' do
      @user.member!

      (Membership::ATTENDANCE - ['Contact Organizer', 'Organizer']).each do |newrole|
        @membership.role = newrole
        @membership.save

        visit event_schedule_index_path(@event)
        expect(page.body).not_to have_link("Add an item on #{@weekday}")

        visit event_schedule_day_path(@event, @day)
        expect(current_path).not_to eq(event_schedule_day_path(@event, @day))
        expect(page.body).to have_text('Only staff and event organizers may modify the schedule')
      end
    end

    it 'allows non-admin users who are organizers of the event' do
      @user.member!
      @membership.role = 'Organizer'
      @membership.save

      click_link "Add an item on #{@weekday}"
      expect(current_path).to eq(event_schedule_day_path(@event, @day))
    end
  end
end

## This test crashes rspec with:
# Failure/Error: Unable to find matching line from backtrace
# ActiveRecord::StatementInvalid:
#  SQLite3::BusyException: database is locked: UPDATE "users" SET "last_sign_in_at" = ?, "current_sign_in_at" = ?, "last_sign_in_ip" = ?, "current_sign_in_ip" = ?, "sign_in_count" = ?, "updated_at" = ? WHERE "users"."id" = ?
## Failure occurs at the line 'visit event_schedule_edit_path(@event, @item)'
## Possible solution: http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/

# feature 'Deleting a Schedule Item', :devise, :js do
#   before do
#     Warden.test_reset!
#     @user = FactoryGirl.create(:user)
#     login_as(@user, scope: :user)
#     @user.confirmed_at = Time.now
#     @user.save
#   end
#
#   it 'Clicking the Delete button on the edit form deletes the item' do
#     @item = FactoryGirl.create(:schedule)
#     @event = @item.event
#     item_id = @item.id
#
#     Capybara.current_driver = :selenium
#
#     visit event_schedule_edit_path(@event, @item)
#     click_link 'Delete Schedule Item'
#     page.driver.browser.switch_to.alert.accept
#     expect(Schedules.where(id: item_id)).to be_empty
#   end
# end