# app/jobs/email_staff_confirmation_notice_job.rb
#
# Copyright (c) 2018 Banff International Research Station.
# This file is part of Workshops. Workshops is licensed under
# the GNU Affero General Public License as published by the
# Free Software Foundation, version 3 of the License.
# See the COPYRIGHT file for details and exceptions.

# Initiates StaffMailer to confirm RSVPs
class EmailStaffConfirmationNoticeJob < ApplicationJob
  queue_as :urgent

  def perform(membership_id, msg, to)
    membership = Membership.find_by_id(membership_id)
    StaffMailer.confirmation_notice(membership, msg, to).deliver_now
  end
end
