require 'spec_helper'

describe 'artifactory' do
  it { should contain_package('artifactory') }
  it { should contain_service('artifactory') }
end
