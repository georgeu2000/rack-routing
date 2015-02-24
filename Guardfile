
guard :rspec, cmd: 'rspec spec', all_on_start:true do
  watch(%r{^lib/rack/(.+)\.rb$})        { 'spec'   }
  watch(%r{^lib/rack/route.rb$})        { 'spec'   }
  watch(%r{^spec/config/(.+)$})         { 'spec'   }
  watch(%r{^spec/(.+)\.rb$})            { 'spec'   }
  
  watch('spec/spec_helper.rb')          { 'spec'   }
  watch('Gemfile.lock')                 { 'bundle' }
end
