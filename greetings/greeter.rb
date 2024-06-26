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

  def initialize
    @freshmen_templates = TemplateDir.new('templates/freshmen')
    @old_stager_templates = TemplateDir.new('templates/old_stagers')
  end

  def call(name:, old_stager: false)
    templates = old_stager ? @old_stager_templates : @freshmen_templates
    templates.render_random(name)
  end
end
