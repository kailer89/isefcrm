# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "watu_table_builder"
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Petrik de Heus", "Andrew C. Greenberg", "Jason Cheong-Kee-You", "J. Pablo Fern\u{e1}ndez"]
  s.date = "2012-02-13"
  s.description = "Rails builder for creating tables and calendars inspired by ActionView's FormBuilder."
  s.email = ["pupeno@watuhq.com"]
  s.homepage = "https://github.com/watu/table_builder"
  s.require_paths = ["lib"]
  s.rubyforge_project = "table_builder"
  s.rubygems_version = "1.8.16"
  s.summary = "Rails builder for creating tables and calendars inspired by ActionView's FormBuilder."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<actionpack>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<actionpack>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<actionpack>, [">= 0"])
  end
end
