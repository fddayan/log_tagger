# LogTagger

Utility for filtering log entries using regular expresions.

I was tierd of using `cat some.log | grep [REGEX]`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'log_tagger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install log_tagger

## Usage

* Create a `Logtags` with the tag definitions
* Run one of the sub commands with `taglog`

### Logtags

`Logtags`
For example to filter log files from Heroku

```ruby
LogTagger.define do
  tag :memory,       /sample#memory_total=(\d*.\d*MB)/
  tag :state ,       /State changed from/
  tag :deploy,       /Deploy/
  tag :router,       /heroku\[router\]\: at=info method=.*path="(.*)" host/
  tag :web,          /heroku.web.1/
  tag :assets,       /assets/
  tag :time,         /(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2})/
end
```

### Usage

    Usage: taglog [command] [options] files
        -h, --help      Display this help message.

    Available commands:

      tag       Tag all lines without filtering or applying tranformations
      filter    Filter lines in log file by tags
      count     Count tags on log file
      summary   List tag definitions available

### Commands

#### tag
Prints all the lines of the log file tagged

	Usage: taglog [command] [options] files
    -d, --definitions      Logtags file with tag definitions
    
Example

	taglog tag ./path/to/file.log
	
	[assets][time]2014-XX-XXT16:53:19.029208+00:00 app[web.1]: cache: [GET /assets/XXXXXX] miss
	[memory][web][time]2014-XX-XXT16:53:11.612719+00:00 heroku[web.1]: ... sample#memory_total=379.29MB sample#memory_rss=377.62MB sample#memory_cache=1.66MB sample#memory_swap
	...

#### filter 
Prints the lines of the log file that matches the tags

	Usage: taglog [command] [options] files
	    -i, --include          Include Tags (tags-to-filter,..[:tags-to-print,...])
	    -n, --no-labels        Do not display labels
	    -d, --definitions      Logtags file with tag definitions

Example

	taglog filter --i web,memory:memory ./path/to/file.log
	[web][memory]	379.17MB	
	[web][memory]	379.19MB	
	[web][memory]	379.19MB	
	[web][memory]	379.19MB	
	[web][memory]	379.19MB	
	[web][memory]	379.19MB

#### count 
Count the tags matching the specified tags

	Usage: taglog [command] [options] files
	    -i, --include          Include Tags
	    -d, --definitions      Logtags file with tag definitions
	    
Example

	taglog count ./path/to/file.log
	239	 [web]
	1140 [time]
	128	 [memory]
	10	 [state]
	422	 [router]
	190	 [assets]

#### summary
Prints all the available tags defined 

	Usage: taglog [command] [options] files
	    -d, --definitions      Logtags file with Tag definitions
    
Example

	$ taglog summary
	[memory] => (?-mix:sample#memory_total=\d*.\d*MB)
	[state] => (?-mix:State changed from)
	[deploy] => (?-mix:Deploy)
	[router] => (?-mix:heroku\[router\]\: at=info method=.*)
	[web] => (?-mix:heroku.web.1)
	[assets] => (?-mix:assets)
	[time] => (?-mix:\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2})
	
#### -d / --definitions

default value for `-d` is a file named `Logtags` in current directory

#### -i / -- include

	--include FILTER-TAGS,...[:DISPLAY-TAGS,...]

`--include` expects a a list of tags to filter

*For example:* 

`--include web,memory` displays the lines that matches `web` and `memory`

`--include router,-assets` displays the lines that matches `router` and do not match `assets`,

`--include web,memory:memory` displays the lines that matches `web` and `memory ` and the prints the first capture groups of the regex for `memory`

`--include web,time,memory,-assets:memory,time` displays the lines that matches `web`,`memory`, and `time`, and do not match `assets` and the prints the first capture groups of the regex for `memory` and the first capture group for `time`


## Contributing

1. Fork it ( https://github.com/[my-github-username]/log_tagger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
