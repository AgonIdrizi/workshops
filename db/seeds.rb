# Data can be loaded with the `rake db:seed' command (or created alongside the db with db:setup).

# This file contains two fake workshops, to be used for Schedule Templates.
# You should change the locations from LOC1 and LOC2 to something relevant for you,
# and matching the location names in config/settings/location.yml.
#
# If you have only one location, delete the second event.
#
# The example schedules are in UTC -7 Time Zone.

event = Event.create!(
    {code: "15w0001", name: "5 Day Workshop Schedule Template", short_name: "Schedule Template", start_date: "2015-01-04", end_date: "2015-01-09", event_type: "5 Day Workshop", location: "LOC1", description: "A template for LOC1 staff to configure the default schedules for 5-Day Workshops at LOC1.", press_release: "", max_participants: 5, door_code: nil, booking_code: "", updated_by: "db seed", template: true, time_zone: 'Mountain Time (US & Canada)'}
)

Schedule.create!([
                     {event: event, lecture_id: nil, start_time: "2015-01-04 23:00:00 UTC", end_time: "2015-01-05 00:30:00 UTC", name: "Check-in begins at 16:00 on Sunday and is open 24 hours", description: "", location: "Front Desk", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-05 00:30:00 UTC", end_time: "2015-01-05 02:30:00 UTC", name: "Dinner", description: "A buffet dinner is served daily between 5:30pm and 7:30pm in the Dining Room, the top floor of the Recreation Building.", location: "Dining Room", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-05 03:00:00 UTC", end_time: "2015-01-05 05:00:00 UTC", name: "Informal gathering ", description: "", location: "Main Lounge", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-05 14:00:00 UTC", end_time: "2015-01-05 15:45:00 UTC", name: "Breakfast", description: "Breakfast is served daily between 7 and 9am in the Dining Room, the top floor of the Recreation Building.", location: "Dining Room", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-05 15:45:00 UTC", end_time: "2015-01-05 16:00:00 UTC", name: "Introduction and Welcome by LOC1 Station Manager", description: "", location: "Main Building 201", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-05 17:00:00 UTC", end_time: "2015-01-05 17:30:00 UTC", name: "Coffee Break", description: "", location: "Main Building Foyer", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-05 18:30:00 UTC", end_time: "2015-01-05 20:00:00 UTC", name: "Lunch", description: "", location: "Dining Room", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-05 20:00:00 UTC", end_time: "2015-01-05 21:00:00 UTC", name: "Guided Tour of Campus", description: "Meet in the Residence Building Lounge for a guided tour of campus.", location: "Residence Building Lounge", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-05 21:00:00 UTC", end_time: "2015-01-05 21:20:00 UTC", name: "Group Photo", description: "Meet in foyer of Main Building to participate in the LOC1 group photo.", location: "Main Building Foyer", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-06 00:30:00 UTC", end_time: "2015-01-06 02:30:00 UTC", name: "Dinner", description: "A buffet dinner is served daily between 5:30pm and 7:30pm in the Dining Room.", location: "Dining Room", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-06 17:00:00 UTC", end_time: "2015-01-06 17:30:00 UTC", name: "Coffee Break", description: "", location: "Main Building Foyer", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-06 18:30:00 UTC", end_time: "2015-01-06 20:30:00 UTC", name: "Lunch", description: "", location: "Dining Room", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-06 22:00:00 UTC", end_time: "2015-01-06 22:30:00 UTC", name: "Coffee Break", description: "", location: "Main Building Foyer", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-05 22:00:00 UTC", end_time: "2015-01-05 22:30:00 UTC", name: "Coffee Break", description: "", location: "Main Building Foyer", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-07 17:00:00 UTC", end_time: "2015-01-07 17:30:00 UTC", name: "Coffee Break", description: "", location: "Main Building Foyer", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-07 18:30:00 UTC", end_time: "2015-01-07 20:30:00 UTC", name: "Lunch", description: "", location: "Dining Room", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-07 20:30:00 UTC", end_time: "2015-01-08 00:30:00 UTC", name: "Free Afternoon", description: "", location: "National Park", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-08 17:00:00 UTC", end_time: "2015-01-08 17:30:00 UTC", name: "Coffee Break", description: "", location: "Main Building Foyer", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-08 18:30:00 UTC", end_time: "2015-01-08 20:30:00 UTC", name: "Lunch", description: "", location: "Dining Room", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-08 22:00:00 UTC", end_time: "2015-01-08 22:30:00 UTC", name: "Coffee Break", description: "", location: "Main Building Foyer", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-09 14:00:00 UTC", end_time: "2015-01-09 16:00:00 UTC", name: "Breakfast", description: "", location: "Dining Room", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-09 17:00:00 UTC", end_time: "2015-01-09 17:30:00 UTC", name: "Coffee Break", description: "", location: "Main Building Foyer", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-09 19:30:00 UTC", end_time: "2015-01-09 20:30:00 UTC", name: "Lunch from 11:30 to 13:30", description: "", location: "Dining Room", updated_by: "db seed", staff_item: nil},
                     {event: event, lecture_id: nil, start_time: "2015-01-09 19:00:00 UTC", end_time: "2015-01-09 19:30:00 UTC", name: "Checkout by Noon", description: "5-day workshop participants are welcome to use LOC1 facilities until 3 pm on Friday, although participants are still required to checkout of the guest rooms by 12 noon.", location: "Front Desk", updated_by: "db seed", staff_item: nil}
                 ])

event2 = Event.create!(
    {code: "15w0002", name: "LOC2 5-Day Workshop Schedule Template", short_name: "LOC2 Template", start_date: "2015-01-04", end_date: "2015-01-09", event_type: "5 Day Workshop", location: "LOC2", description: "A template for LOC2 staff to configure the default schedules for 5-Day Workshops at LOC2.", press_release: "", max_participants: 5, door_code: nil, booking_code: "", updated_by: "db seed", template: true, time_zone: "Mexico City"}
)

Schedule.create!([
                     {event: event2, lecture_id: nil, start_time: "2015-01-04 20:00:00 UTC", end_time: "2015-01-05 05:59:00 UTC", name: "Check-in begins - open 24 hours", description: "", location: "Front desk at your assigned hotel", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-06 01:00:00 UTC", end_time: "2015-01-06 04:00:00 UTC", name: "Dinner", description: "", location: "Restaurant Hotel One", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-05 02:30:00 UTC", end_time: "2015-01-05 03:30:00 UTC", name: "Informal gathering ", description: "A welcome drink will be served at the hotel.\r\n", location: "Hotel One", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-05 13:30:00 UTC", end_time: "2015-01-05 14:45:00 UTC", name: "Breakfast", description: "", location: "Restaurant Hotel One", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-05 14:45:00 UTC", end_time: "2015-01-05 15:00:00 UTC", name: "Introduction and Welcome", description: "", location: "Conference Room", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-05 16:30:00 UTC", end_time: "2015-01-05 17:00:00 UTC", name: "Coffee Break", description: "", location: "Conference Room", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-05 19:30:00 UTC", end_time: "2015-01-05 21:00:00 UTC", name: "Lunch", description: "", location: "Restaurant Hotel One", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-05 01:00:00 UTC", end_time: "2015-01-05 03:00:00 UTC", name: "Dinner", description: "", location: "Restaurant Hotel One", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-06 16:30:00 UTC", end_time: "2015-01-06 17:00:00 UTC", name: "Coffee Break", description: "", location: "Conference Room", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-06 19:30:00 UTC", end_time: "2015-01-06 21:00:00 UTC", name: "Lunch", description: "", location: "Restaurant Hotel One", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-07 01:00:00 UTC", end_time: "2015-01-07 03:00:00 UTC", name: "Dinner", description: "", location: "Restaurant Hotel One", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-07 16:30:00 UTC", end_time: "2015-01-07 17:00:00 UTC", name: "Coffee Break", description: "", location: "Conference Room", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-07 19:30:00 UTC", end_time: "2015-01-07 21:00:00 UTC", name: "Lunch", description: "", location: "Restaurant Hotel One", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-08 01:00:00 UTC", end_time: "2015-01-08 03:00:00 UTC", name: "Dinner", description: "", location: "Restaurant Hotel One", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-09 01:00:00 UTC", end_time: "2015-01-09 03:00:00 UTC", name: "Dinner", description: "", location: "Restaurant Hotel One", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-08 19:30:00 UTC", end_time: "2015-01-08 21:00:00 UTC", name: "Lunch", description: "", location: "Restaurant Hotel One", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-08 16:30:00 UTC", end_time: "2015-01-08 17:00:00 UTC", name: "Coffee Break", description: "", location: "Conference Room", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-09 19:30:00 UTC", end_time: "2015-01-09 21:00:00 UTC", name: "Lunch", description: "", location: "Restaurant Hotel One", updated_by: "db seed", staff_item: nil},
                     {event: event2, lecture_id: nil, start_time: "2015-01-09 16:30:00 UTC", end_time: "2015-01-09 17:00:00 UTC", name: "Coffee Break", description: "", location: "Conference Room", updated_by: "db seed", staff_item: nil}
                 ])
