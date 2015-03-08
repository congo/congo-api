require 'rails_helper'

module CongoHelper
  def create_admin
    account = Account.create \
      name: 'Admin',
      tagline: 'GroupHub administrative account',
      plan_name: 'admin'

    user = User.create \
      first_name: 'GroupHub',
      last_name: 'Admin',
      email: 'admin@grouphub.io',
      password: 'testtest'

    Role.create \
      user_id: user.id,
      account_id: account.id,
      name: 'admin'
  end

  def signin_admin
    visit '/'

    all('a', text: 'Sign In').first.click

    expect(page).to have_content('Email')

    fill_in 'Email', with: 'admin@grouphub.io'
    fill_in 'Password', with: 'testtest'

    all('button', text: 'Sign In').first.click

    expect(page).to have_content('Administrator Dashboard')
  end

  def signout_admin
    all('a', text: 'GroupHub').first.click

    expect(page).to have_content('Sign Out')

    all('a', text: 'Sign Out').first.click

    expect(page).to have_content('You have signed out.')
    expect(page).to have_content('The next generation')
  end

  def create_broker
    account = Account.create \
      name: 'First Account',
      tagline: '#1 Account',
      plan_name: 'basic'

    user = User.create \
      first_name: 'Barry',
      last_name: 'Broker',
      email: 'barry@broker.com',
      password: 'barry'

    Role.create \
      user_id: user.id,
      account_id: account.id,
      name: 'broker'
  end

  def signin_broker
    visit '/'

    all('a', text: 'Sign In').first.click

    expect(page).to have_content('Email')

    fill_in 'Email', with: 'barry@broker.com'
    fill_in 'Password', with: 'barry'

    all('button', text: 'Sign In').first.click

    expect(page).to have_content('Broker Dashboard: First Account')
  end

  def signout_broker
    all('a', text: 'Barry').first.click

    expect(page).to have_content('Sign Out')

    all('a', text: 'Sign Out').first.click

    expect(page).to have_content('You have signed out.')
    expect(page).to have_content('The next generation')
  end

  def create_customer
    account = Account.create \
      name: 'First Account',
      tagline: '#1 Account',
      plan_name: 'basic'

    user = User.create \
      first_name: 'Candice',
      last_name: 'Customer',
      email: 'candice@customer.com',
      password: 'candice'

    Role.create \
      user_id: user.id,
      account_id: account.id,
      name: 'customer'
  end

  def signin_customer
    visit '/'

    all('a', text: 'Sign In').first.click

    expect(page).to have_content('Email')

    fill_in 'Email', with: 'candice@customer.com'
    fill_in 'Password', with: 'candice'

    all('button', text: 'Sign In').first.click

    expect(page).to have_content('Welcome, Candice!')
  end

  def signout_customer
    all('a', text: 'Candice').first.click

    expect(page).to have_content('Sign Out')

    all('a', text: 'Sign Out').first.click

    expect(page).to have_content('You have signed out.')
    expect(page).to have_content('The next generation')
  end

  def create_group_for(account)
    carrier = Carrier.create! \
      name: 'Blue Cross',
      properties: {
        npi: '1467560003',
        first_name: 'Brad',
        last_name: 'Bluecross',
        service_types: ['health_benefit_plan_coverage'],
        trading_partner_id: 'MOCKPAYER'
      }

    carrier_account = CarrierAccount.create! \
      name: 'My Broker Blue Cross',
      carrier_id: carrier.id,
      account_id: account.id

    benefit_plan = BenefitPlan.create! \
      account_id: account.id,
      carrier_account_id: carrier_account.id,
      name: 'Best Health Insurance PPO',
      is_enabled: true

    group = Group.create! \
      account_id: account.id,
      name: 'My Group',
      is_enabled: true

    GroupBenefitPlan.create! \
      group_id: group.id,
      benefit_plan_id: benefit_plan.id
  end

  def scroll_by(y)
    page.execute_script "window.scrollBy(0, #{y})"
  end

  def scroll_to_bottom
    scroll_by(10000)
  end

  def current_user_data
    page.evaluate_script('window.congo.currentUser')
  end

  def wait_for(message, seconds = 5, &block)
    (seconds * 10).times do |i|
      break if yield
      sleep(i * 0.1)
    end

    fail("Expected #{message}") unless yield
  end
end
