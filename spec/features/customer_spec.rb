require 'rails_helper'

RSpec.feature "Customers", type: :feature do
  scenario 'Verifica link do cadastro de cliente' do
    visit(root_path)
    expect(page).to have_link('Cadastro de Clientes')
  end

  scenario 'Verifica link de novo cliente' do
    visit(root_path)
    expect(page).to have_content('Cadastro de Clientes')
    expect(page).to have_link('Cadastro de Clientes')
  end

  scenario 'Verifica o formulário de novo cliente' do
    puts customer_path
    visit(customer_path)
    click_on('Novo Cliente')
    expect(page).to have_content('Novo Cliente')
  end
end
