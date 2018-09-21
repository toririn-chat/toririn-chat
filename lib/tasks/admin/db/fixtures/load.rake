namespace 'tc:db:fixtures' do
  desc "Loads fixtures into the current environment's database"
  task load: :environment do
    Rails.root.join('test', 'fixtures', 'files', 'avatars')
    binding.pry
    
    # ActiveRecord::Base.transaction do
    #   # create_users
    # end
  end
end
