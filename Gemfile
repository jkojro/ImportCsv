source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
gem 'rails-controller-testing'
gem 'rubocop', require: false
gem 'rubocop-rspec', require: false
gem 'sidekiq'
gem 'spree', github: 'spree/spree', branch: 'master'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: 'master'

group :test do
  gem 'rspec-sidekiq'
end

gemspec
