require 'spec_helper_acceptance'

pp = 'puppet apply spec/fixtures/acceptance.pp --modulepath .. --detailed-exitcodes'

describe command(pp) do
  its(:exit_status) { should_not eq 1 }
end

context 'Verifying Windows AD Forest Configuration' do
  print "Acceptance Testing for Windows AD Forest Configuration\n"

end

context 'Verifying Windows AD Organizational Unit (OU) Configuration' do
  print "Acceptance Testing for Windows AD Organizational Unit (OU)\n"

end

context 'Verifying Windows AD Group Configuration' do
  print "Acceptance Testing for Windows AD Group\n"

end

context 'Verifying Windows AD Users Configuration' do
  print "Acceptance Testing for Windows AD Users\n"

end
