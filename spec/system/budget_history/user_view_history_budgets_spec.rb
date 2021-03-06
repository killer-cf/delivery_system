require 'rails_helper'

describe 'user sees budget history' do
  it 'from initial page' do
    user = User.create!(email: 'kilder@gmail.com.br', password: 'password')
    login_as(user)
    carrier1 = Carrier.create!(fantasy_name: 'Pac', cnpj: '12345678901234', domain: 'pac.com.br', address: 'Av. Republica do Libano, 145', email: 'support@pac.com.br')
    carrier2 = Carrier.create!(fantasy_name: 'DLL', cnpj: '12345678901237', domain: 'dll.com.br', address: 'Av. Geraldo Patrin, 745', email: 'support@dll.com.br')
    BudgetHistory.create!(carrier: carrier1, freight: 155.0 , deadline: 5, weight: 10, distance: 2000, cubic_size: 1.5)
    BudgetHistory.create!(carrier: carrier1, freight: 55.0 , deadline: 8, weight: 14, distance: 1000, cubic_size: 1)
    BudgetHistory.create!(carrier: carrier2, freight: 130.0 , deadline: 5, weight: 10, distance: 2500, cubic_size: 1.1)

    visit orders_path
    click_on 'Historico'
    
    expect(page).to have_content 'Pac - frete R$ 155,00 | 5 dias úteis | 10.0kg | 2000km | 1.5M cúbicos'
    expect(page).to have_content 'Pac - frete R$ 55,00 | 8 dias úteis | 14.0kg | 1000km | 1.0M cúbicos'
    expect(page).to have_content 'DLL - frete R$ 130,00 | 5 dias úteis | 10.0kg | 2500km | 1.1M cúbicos'
  end

  it 'and there are no budget_histories' do
    user = User.create!(email: 'kilder@gmail.com.br', password: 'password')
    login_as(user)
    carrier1 = Carrier.create!(fantasy_name: 'Pac', cnpj: '12345678901234', domain: 'pac.com.br', address: 'Av. Republica do Libano, 145', email: 'support@pac.com.br')
    carrier2 = Carrier.create!(fantasy_name: 'DLL', cnpj: '12345678901237', domain: 'dll.com.br', address: 'Av. Geraldo Patrin, 745', email: 'support@dll.com.br')

    visit orders_path
    click_on 'Historico'
    
    expect(page).to have_content 'Sem historico'
  end
end