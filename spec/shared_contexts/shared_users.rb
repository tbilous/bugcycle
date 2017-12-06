shared_context 'users', users: true do
  let!(:country) { create_list(:country, 3) }
  let!(:city) do
    country.each { |c| create_list(:city, 3, country_id: c.id) }
  end
  # country = if Country.count.positive?
  #             Country.first
  #           else
  #             Country.create!(id: 9, title_en: 'USA')
  #           end
  # city = if City.count.positive?
  #          City.first
  #        else
  #          City.create!(id: 1, country_id: country.id, title_en: 'Chernivtsi')
  #        end
  let(:user) { create(:user, country_id: country.sample.id, city_id: city.sample.id, name: 'user') }
  let(:writer) { create(:user, country_id: country.sample.id, city_id: city.sample.id, name: 'writer') }
  let(:reader) { create(:user, country_id: country.sample.id, city_id: city.sample.id, name: 'reader') }
  let(:admin) { create(:user, admin: true, country_id: country.sample.id, city_id: city.sample.id) }
  let(:bot) { create(:user, vk: true, country_id: country.sample.id, city_id: city.sample.id) }
end
