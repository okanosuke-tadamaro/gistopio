require 'spec_helper'

describe Post do
	
	it { should validate_presence_of :title }
	it { should validate_presence_of :body }

	it { should belong_to :user }
	it { should have_many :comments }
	it { should have_and_belong_to_many :tags }

end
