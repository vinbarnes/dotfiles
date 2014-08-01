if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

Pry.config.editor = "emacs"

if defined?(Rails) && Rails.env
  extend Rails::ConsoleMethods

  ActiveRecord::Base.logger = Logger.new(STDOUT)
end