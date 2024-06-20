class Kamal::Configuration::Validator::Alias < Kamal::Configuration::Validator
  def validate!
    super

    name = context.delete_prefix("aliases/")

    if name !~ /\A[a-z0-9_-]+\z/
      error "Invalid alias name: '#{name}'. Must only contain lowercase letters, alphanumeric, hyphens and underscores."
    end

    if Kamal::Cli::Main.original_commands.include?(name)
      error "Alias '#{name}' conflicts with a built-in command."
    end

    if config["command"].empty?
      error "Alias '#{name}': command is required."
    end
  end
end
