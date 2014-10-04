# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "omniauth-google-apps"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dingding Ye"]
  s.date = "2012-05-11"
  s.description = "OmniAuth strategy for Google Apps."
  s.email = ["yedingding@gmail.com"]
  s.homepage = "https://github.com/sishen/omniauth-google-apps"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.16"
  s.summary = "OmniAuth strategy for Google Apps."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth>, ["~> 1.0"])
      s.add_runtime_dependency(%q<omniauth-openid>, ["~> 1.0"])
      s.add_runtime_dependency(%q<ruby-openid-apps-discovery>, ["~> 1.2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.7"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
    else
      s.add_dependency(%q<omniauth>, ["~> 1.0"])
      s.add_dependency(%q<omniauth-openid>, ["~> 1.0"])
      s.add_dependency(%q<ruby-openid-apps-discovery>, ["~> 1.2.0"])
      s.add_dependency(%q<rspec>, ["~> 2.7"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
    end
  else
    s.add_dependency(%q<omniauth>, ["~> 1.0"])
    s.add_dependency(%q<omniauth-openid>, ["~> 1.0"])
    s.add_dependency(%q<ruby-openid-apps-discovery>, ["~> 1.2.0"])
    s.add_dependency(%q<rspec>, ["~> 2.7"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
  end
end
