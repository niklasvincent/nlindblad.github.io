import os
import sys

import jinja2
import yaml


def load_config(config_filename):
    with open(config_filename) as f:
        return yaml.load(f)


def render_from_template(config, template_filename):
    path, filename = os.path.split(template_filename)
    return jinja2.Environment(
        loader=jinja2.FileSystemLoader(path or './')
    ).get_template(filename).render(config)


def main(template_filename, config_filename, output_filename):
    config = load_config(config_filename)
    with open(output_filename, 'w') as f:
        output = render_from_template(config, template_filename)
        f.write(output.encode('ascii', 'ignore'))


if __name__ == '__main__':
    current_directory=os.path.dirname(os.path.realpath(__file__))
    main(
        template_filename=os.path.join(
            current_directory,
            'templates/nginx.conf.j2'
        ),
        config_filename=os.path.join(*[
            current_directory,
            '..',
            '_config.yml'
        ]),
        output_filename=os.path.join(
            current_directory,
            'nginx.conf'
        )
    )
