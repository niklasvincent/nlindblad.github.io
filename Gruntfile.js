module.exports = function(grunt) {

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        concat: {
            dist: {
                src: [
                    '_js/*.js',
                ],
                dest: 'js/scripts.js',
            }
        },

        uglify: {
            build: {
                src: 'js/scripts.js',
                dest: 'js/build/scripts.min.js'
            }
        },

        sass: {
            dist: {
                options: {
                    style: 'compressed'
                },
                files: {
                    '_css/main.css': '_sass/main.scss',
                    '_css/menubar.css': '_sass/navigation/menubar.scss',
                }
            }
        },

        cssmin: {
            options: {
                report: 'gzip',
                shorthandCompacting: false,
                roundingPrecision: -1,
            },
            target: {
                files: [{
                    '_includes/style.css': [
                        '_css/normalize.min.css',
                        '_css/google-web-fonts.css',
                        '_css/font-awesome.css',
                        '_css/main.css',
                        '_css/timeline.css',
                        '_css/menubar.css',
                        '_css/pygments.css',
                    ]
                }]
            }
        },

        watch: {
            scripts: {
                files: ['_js/*.js'],
                tasks: ['concat', 'uglify'],
                options: {
                    spawn: false,
                },
            },
            css: {
                files: ['_sass/*.scss', '_sass/navigation/*.scss'],
                tasks: ['sass', 'cssmin'],
                options: {
                    spawn: false,
                }
            }
        }

    });

    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-contrib-cssmin');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-uglify');

    grunt.registerTask('default', ['watch']);

};