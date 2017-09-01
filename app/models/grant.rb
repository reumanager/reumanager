class Grant < ActiveRecord::Base
	has_many :users
	has_many :settings
	has_many :snippets
	# has_one :admin_account
	# has_one :grant_setting
	# has_one :grant_snippet

	validates :subdomain, exclusion: { in: %w(www admin), message: "%{value} is reserved"}
	after_create :create_tenant
	after_destroy :destroy_tenant
	accepts_nested_attributes_for :settings
	accepts_nested_attributes_for :users
	accepts_nested_attributes_for :snippets

	def create_tenant
		Apartment::Tenant.create(subdomain)
		Apartment::Tenant.switch!(subdomain)
		Setting.load_from_yaml(self)
		Snippet.load_from_yaml(self)
		Apartment::Tenant.switch!
	end

	def destroy_tenant
		Apartment::Tenant.drop(subdomain)
	end


end