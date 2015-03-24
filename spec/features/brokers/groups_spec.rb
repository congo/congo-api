require 'rails_helper'

describe 'As a broker', js: true do

  describe 'Groups' do

    it 'allows them to create a group'
    it 'allows them to delete a group'
    it 'allows them to view a group'
    it 'allows them to enable and disable a group'

    describe 'Benefit Plans' do

      it 'allows them to add a benefit plan to a group'
      it 'allows them to remove a benefit plan from a group'
      it 'hides the button to add a benefit plan if there are no remaining enabled benefit plans'

    end

    describe 'Members' do

      it 'allows for a new member to be invited'
      it 'allows for a new member to be revoked'
      it 'allows for an invitation to be sent'
      it 'allows for an invitation to be sent to all pending members'
      it 'allows for a member profile to be viewed'

      describe 'Applications' do

        it 'shows when a user has applied for a plan'
        it 'shows when a user has declined a plan'
        it 'allows for an application to be reviewed and approved'
        it 'allows for an application status to be seen'

      end

    end

    describe 'Group Admins' do

      it 'allows for a new member to be invited'
      it 'allows for a new member to be revoked'
      it 'allows for an invitation to be sent'
      it 'allows for an invitation to be sent to all pending members'
      it 'allows for a member profile to be viewed'

    end

  end

end
