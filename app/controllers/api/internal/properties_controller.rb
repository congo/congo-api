class Api::Internal::PropertiesController < ApplicationController
  protect_from_forgery

  def accounts
    respond_to do |format|
      format.json {
        render json: {
          elements: [
            {
              type: 'text',
              name: 'name',
              title: 'Name',
              placeholder: 'Enter a Company Name…'
            },
            {
              type: 'text',
              name: 'tagline',
              title: 'Tagline',
              placeholder: 'Company Tagline'
            },
            {
              type: 'text',
              name: 'tax_id',
              title: 'Tax ID',
              placeholder: 'Tax ID'
            },
            {
              type: 'text',
              name: 'first_name',
              title: 'Account Contact',
              placeholder: 'Account Contact First Name'
            },
            {
              type: 'text',
              name: 'last_name',
              title: 'Last Name',
              placeholder: 'Account Contact Last Name'
            },
            {
              type: 'text',
              name: 'phone',
              title: 'Phone Number',
              placeholder: 'Phone Number'
            }
          ]
        }
      }
    end
  end

  def carriers
    respond_to do |format|
      format.json {
        render json: {
          elements: [
            {
              type: 'text',
              name: 'name',
              title: 'Name',
              placeholder: 'Enter a Carrier Organization Name…'
            },
            {
              type: 'text',
              name: 'npi',
              title: 'NPI',
              placeholder: 'Enter an NPI…'
            },
            {
              type: 'text',
              name: 'trading_partner_id',
              title: 'Trading Partner ID',
              placeholder: 'Enter the Carrier\'s Trading Partner ID…'
            },
            {
              type: 'text',
              name: 'service_types',
              title: 'Service Types (comma-separated, underscored_text)',
              placeholder: 'Enter the Carrier\'s service types…'
            },
            {
              type: 'text',
              name: 'tax_id',
              title: 'Tax ID',
              placeholder: 'Enter the Carrier\'s Tax ID…'
            },
            {
              type: 'text',
              name: 'first_name',
              title: 'Carrier Contact First Name',
              placeholder: 'Enter the Primary Contact\'s First Name for the Carrier…'
            },
            {
              type: 'text',
              name: 'last_name',
              title: 'Carrier Contact Last Name',
              placeholder: 'Enter the Primary Contact\'s First Name for the Carrier…'
            },
            {
              type: 'text',
              name: 'address_1',
              title: 'Address',
              placeholder: 'Enter an Address…'
            },
            {
              type: 'text',
              name: 'address_2',
              placeholder: ''
            },
            {
              type: 'text',
              name: 'city',
              title: 'City',
              placeholder: 'Enter a City…'
            },
            {
              type: 'text',
              name: 'state',
              title: 'State',
              placeholder: 'Enter a State…'
            },
            {
              type: 'text',
              name: 'zip',
              title: 'Zip',
              placeholder: 'Enter a Zip…'
            },
            {
              type: 'text',
              name: 'phone',
              title: 'Phone',
              placeholder: 'Enter a Phone…'
            }
          ]
        }
      }
    end
  end
end

