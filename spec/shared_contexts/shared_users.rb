shared_context 'users', users: true do
  let(:user) { create(:user) }
  let(:writer) { create(:user) }
end
