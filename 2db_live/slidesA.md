<!SLIDE title-slide center >
.notes first slide

![aveiro](aveiro_logo.png)
# Crash course <br> Ruby on Rails #
![RoR](Ruby_on_Rails.png)

<!SLIDE subsection >

# The RUBY language

<!SLIDE transition=fade>

# Ruby is...
>A dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write.

![ruby](ruby.gif)

<small>www.ruby-lang.org/</small>

<!SLIDE small transition=fade>

# Powerful programming language #

## supports multithreading

    @@@ Ruby
    4.times do |i|
        threads << Thread.new do
          mutex.synchronize {
            resource.wait(mutex)
            # complicated task
          }
        end
    end

## supports multiple cores (processes)

    @@@ Ruby
    4.times do |i|
        fork do
          # complicated task
        end
    end

<!SLIDE small transition=fade>

# Ruby is very expressive #

    @@@ Ruby
    # Method example
    def read(path)
      return nil unless File.exist?(path)
      File.read(path)
    end

    # RSpec example
    Post.last.should have(10).comments

<!SLIDE small transition=fade>

# Ruby is elegant #

    @@@ Ruby
    # Sinatra example
    get '/' do
      'Hello world!'
    end

    # Block example
    ChessGame.new do |move|
      move.black_pawn(forward)
      move.white_pawn(forward)
      # ...
      move.white_queen(pwn_king)
    end

<!SLIDE commandline incremental transition=fade>

# Everything is an object! #

	$irb> "foo".class
	String
	$irb> 1.class
	Fixnum
	$irb> abs(-1)
	NoMethodError: undefined method `abs' for main:Object
	$irb> -1.abs()
	1
	$irb> "hello aveiro".pluralize.camelize
	"Hello aveiros"
	$irb> %w(world galaxy).each{|s| puts "hello #{s}".upcase}
	"HELLO WORLD"
	"HELLO GALAXY"

<!SLIDE small transition=fade>

# Ruby classes #

    @@@ Ruby
    class Greeter
      def initialize(name = "World")
        @name = name
      end
      def say_hi
        puts "Hi #{@name}!"
      end
      def say_bye
        puts "Bye #{@name}, come back soon."
      end
    end

<!SLIDE small transition=fade>

# Ruby arrays, hashes, ranges #

    @@@ Ruby
    array = ["one", "two", "nine"]
    hash = {one: 1, two: 2, nine: 9}
    range = 1..4
    range.to_a
    # => [2, 3, 4]
    range.include?(3)
    # => true







