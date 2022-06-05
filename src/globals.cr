class Globals
  @@version : String = {{ `shards version #{__DIR__}`.chomp.stringify }}

  def self.version
    @@version
  end
end
