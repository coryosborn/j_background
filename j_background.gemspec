Gem::Specification.new do |s|
  s.name = %q{j_background}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cory Osborn"]
  s.date = %q{2009-05-30}
  s.email = %q{cory@coryosborn.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "j_background.gemspec",
     "lib/j_background.rb",
     "lib/j_background/base.rb",
     "lib/j_background/proc_task.rb",
     "lib/j_background/task.rb",
     "test/j_background/test_task.rb",
     "test/j_background_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/coryosborn/j_background}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A wrapper for using Java's Thread Pools for asynchronous tasks}
  s.test_files = [
    "test/j_background/test_task.rb",
     "test/j_background_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
