shared_context 'users', users: true do
  let(:user) { create(:user) }
  let(:john) { create(:user) }
  let(:bill) { create(:user) }
end
