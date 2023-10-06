require 'rails_helper'

RSpec.feature "Customers", type: :feature do
  scenario 'Verifica link do cadastro de cliente' do
    visit(root_path)
    expect(page).to have_link('Cadastro de Clientes')
  end

  scenario 'Verifica link de novo cliente' do
    visit(root_path)
    click_on('Cadastro de Clientes')
    expect(page).to have_content('Listando Clientes')
    expect(page).to have_link('Novo Cliente')
  end

  scenario 'Verifica o formulário de novo cliente' do
    visit(customers_path)
    click_on('Novo Cliente')
    expect(page).to have_content('Novo Cliente')
  end

  scenario 'Cadastra um cliente válido' do
    visit(new_customer_path)
    customer_name = Faker::Name.name

    fill_in('customer_name', with: customer_name)
    fill_in('customer_email', with: Faker::Internet.email)
    fill_in('customer_phone', with: Faker::PhoneNumber.phone_number)
    attach_file('customer_avatar', "#{Rails.root}/spec/features/avatar.png")
    choose(option: ['S', 'N'].sample)
    click_on('Criar Cliente')

    expect(page).to have_content('Cliente cadastro com sucesso.')
    expect(Customer.last.name).to eq(customer_name)
  end

  scenario 'Não pode ficar em branco' do
    visit(new_customer_path)
    click_on('Criar Cliente')
    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'Mostra um cliente' do
    customer = create(:customer)
    visit(customer_path(customer.id))
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)
  end

  scenario 'Testando a Index' do
    customer1 = create(:customer)

    customer2 = create(:customer)

    visit(customers_path)
    expect(page).to have_content(customer1.name).and have_content(customer2.name)
  end

  scenario 'Atualiza um cliente' do
    customer = create(:customer)

    new_name = Faker::Name.name

    visit(edit_customer_path(customer.id))
    fill_in('customer_name', with: new_name)
    click_on('Atualizar Cliente')

    expect(page).to have_content('Cliente atualizado com sucesso!')
    expect(page).to have_content(new_name)
  end

  scenario 'Clica no Link Mostrar da Index' do
    customer = create(:customer)

    visit(customers_path)
    find(:xpath, '/html/body/table/tbody/tr[1]/td[2]/a').click

    expect(page).to have_content('Mostrando Cliente')
  end

  scenario 'Clica no Link Editar da Index' do
    customer = create(:customer)

    visit(customers_path)
    find(:xpath, '/html/body/table/tbody/tr[1]/td[3]/a').click

    expect(page).to have_content('Editando Cliente')
  end

  scenario 'Apaga um Cliente', js: true do
    customer = create(:customer)

    visit(customers_path)
    find(:xpath, '/html/body/table/tbody/tr[1]/td[4]/a').click
    1.second
    page.driver.browser.switch_to.alert.accept


    expect(page).to have_content('Cliente excluído com sucesso!')
  end
end
