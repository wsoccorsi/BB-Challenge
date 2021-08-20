FactoryBot.define do
  factory :user do
    name { "fake_name" }
    email { "fake_email@email.com" }
    password { 'not_blank' }
    created_at { '2020-02-11 13:30:31' }
    updated_at { '2020-02-11 13:30:32' }
    encrypted_password { rand(999).to_s }
    reset_password_token { rand(999).to_s }
    reset_password_sent_at { '2021-02-11 13:30:31' }
    remember_created_at { '2021-02-11 13:30:32' }
    sign_in_count { rand(999).to_s }
    current_sign_in_at { '2021-03-11 13:30:31' }
    last_sign_in_at { '2021-03-11 13:30:32' }
    current_sign_in_ip { rand(999).to_s }
    last_sign_in_ip { rand(999).to_s }
  end
end
