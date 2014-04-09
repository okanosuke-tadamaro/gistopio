require 'spec_helper'

describe User do

	it { should validate_presence_of :username }
	it { should validate_presence_of :github_access_token }
	it { should validate_uniqueness_of :username }
	it { should validate_uniqueness_of :github_access_token }

	it { should have_many :posts }
	it { should have_many :comments }

end
