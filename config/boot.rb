require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
ENV['EXECJS_RUNTIME'] = 'Node'

RUBY_GC_HEAP_FREE_SLOTS=4096              #           Must be > 0
RUBY_GC_HEAP_INIT_SLOTS=10000             #           Must be > 0
RUBY_GC_HEAP_GROWTH_FACTOR=1.8            #           Must be > 1.0
RUBY_GC_HEAP_GROWTH_MAX_SLOTS=0           # Disabled; Must be > 0
RUBY_GC_HEAP_OLDOBJECT_LIMIT_FACTOR=2.0   #           Must be > 0
RUBY_GC_MALLOC_LIMIT=4000100             # 16 MiB;   Must be > 0

RUBY_GC_MALLOC_LIMIT_MAX=16000100         # 32 MiB;   Must be > 0
RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1    #           Must be > 1.0
RUBY_GC_OLDMALLOC_LIMIT=16000100          # 16 MiB;   Must be > 0
RUBY_GC_OLDMALLOC_LIMIT_MAX=16000100     # 128 MiB;  Must be > 0
RUBY_GC_OLDMALLOC_LIMIT_GROWTH_FACTOR=1.1 #    