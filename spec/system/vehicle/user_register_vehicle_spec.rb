require 'rails_helper'

describe 'User register new vehicle' do
  it 'and must be authenticated' do
    carrier = Carrier.create!(fantasy_name: 'Pac', cnpj: '12345678901234', domain: 'pac.com.br', address: 'Av. Republica do Libano, 145', email: 'support@pac.com.br')
    visit new_carrier_vehicle_path(1)
    expect(current_path).to eq new_user_session_path
  end
  it 'success' do
    carrier = Carrier.create!(fantasy_name: 'DLL', cnpj: '12345678901237', domain: 'dll.com.br', address: 'Av. Geraldo Patrin, 745', email: 'support@dll.com.br')
    user = User.create!(email: 'kilder@dll.com.br', password: 'password')
    login_as(user)

    visit root_path
    find('#menu-desktop').click_on 'Dashboard'
    click_on 'Novo veiculo'

    fill_in 'Marca', with: 'Renault'
    fill_in 'Modelo', with: 'Maxi'
    fill_in 'Placa', with: 'RTF-2222'
    fill_in 'Ano', with: '2022'
    fill_in 'Capacidade', with: '3000'
    click_on 'Cadastrar'

    expect(page).to have_content 'Veiculo cadastrado'
    expect(page).to have_content 'Renault'
    expect(page).to have_content 'Maxi'
    expect(page).to have_content 'RTF-2222'

  end

  it 'with blank fields' do
    carrier = Carrier.create!(fantasy_name: 'DLL', cnpj: '12345678901237', domain: 'dll.com.br', address: 'Av. Geraldo Patrin, 745', email: 'support@dll.com.br')
    user = User.create!(email: 'kilder@dll.com.br', password: 'password')
    login_as(user)

    visit root_path
    find('#menu-desktop').click_on 'Dashboard'
    click_on 'Novo veiculo'
    click_on 'Cadastrar'

    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'Modelo não pode ficar em branco'
    expect(page).to have_content 'Placa não pode ficar em branco'
    expect(page).to have_content 'Ano não pode ficar em branco'
    expect(page).to have_content 'Capacidade não pode ficar em branco'
  end
end
