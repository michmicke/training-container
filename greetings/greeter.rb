require "liquid"

class Greeter
  class Template
    def initialize(path)
      template = File.read(path)
      @liquid_template = Liquid::Template.parse(template)
    end

    def call(name)
      @liquid_template.render("name" => name)
    end
  end

  class TemplateDir
    def initialize(dir_path)
      glob_string = File.join(dir_path, '*.liquid')
      @template_paths = Dir.glob(glob_string)
    end

    def templates
      @template_paths.map do |path|
        Template.new(path)
      end
    end

    def render_random(name)
      templates.sample.(name)
    end
  end

  def initialize(old_stager_enabled: false)
    @old_stager_enabled = false
    @freshmen_templates = TemplateDir.new('templates/freshmen')
    @old_stager_templates = TemplateDir.new('templates/oldstager')
  end

  def enable_old_stager!
    puts "[#{self.class.to_s}] old stagers are now recognized"
    @old_stager_enabled = true
  end

  def call(name:, count: nil)
    templates =
      if old_stager_enabled? && count > 10
        @old_stager_templates
      else
        @freshmen_templates
      end
    templates.render_random(name)
  end

  private

  def old_stager_enabled?
    !!@old_stager_enabled
  end
end
