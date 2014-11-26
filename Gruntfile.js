// Generated on 2014-05-29 using generator-angular 0.8.0
'use strict';

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {

    // Load grunt tasks automatically
    require('load-grunt-tasks')(grunt);

    // Time how long tasks take. Can help when optimizing build times
    require('time-grunt')(grunt);

    // Define the configuration for all the tasks
    grunt.initConfig({

        // Project settings
        yeoman: {
            // configurable paths
            app: 'app',
            dist: 'site'
        },

        // Watches files for changes and runs tasks based on the changed files
        watch: {
            bower: {
                files: ['bower.json'],
                tasks: ['bowerInstall']
            },
            coffee: {
                files: ['<%= yeoman.app %>/scripts/{,*/}*.{coffee,litcoffee,coffee.md}'],
                tasks: ['newer:coffee:dev']
            },
            styles: {
                files: ['<%= yeoman.app %>/styles/{,*/}*.styl'],
                tasks: ['newer:stylus:dev']
            },
            layout: {
                files: [
                    '<%= yeoman.app %>/index.html',
                    '<%= yeoman.app %>/login.html',
                    '<%= yeoman.app %>/layout.html',
                    '<%= yeoman.app %>/views/**/**/*.html',
                    '<%= yeoman.app %>/django_templates/**/*',
                    '<%= yeoman.app %>/js/**/*'
                ],
                tasks: ['newer:copy:dev']

            }
        },


        // Empties folders to start fresh
        clean: {
            dist: {
                files: [
                    {
                        dot: true,
                        src: [
                            '<%= yeoman.dist %>/*',
                            '!<%= yeoman.dist %>/.git*'
                        ]
                    }
                ]
            },
            dev: {
                files: [
                    {
                        dot: true,
                        src: [
                            '<%= yeoman.dist %>/**/*',
                            '!<%= yeoman.dist %>/.git*'
                        ]
                    }
                ]
            }
        },

        // Add vendor prefixed styles
        autoprefixer: {
            options: {
                browsers: ['last 1 version']
            },
            dist: {
                files: [
                    {
                        expand: true,
                        cwd: '.tmp/static/styles/',
                        src: '{,*/}*.css',
                        dest: '.tmp/static/styles/'
                    }
                ]
            }
        },

        // Automatically inject Bower components into the app
        bowerInstall: {
            app: {
                src: [
                  '<%= yeoman.app %>/index.html'
                ]
//                ignorePath: '../../',
//                fileTypes: {
//                  html: {
//                    replace: {
//                      js: '<script src="/static/{{filePath}}"></script>',
//                      css: '<link rel="stylesheet" href="/static/{{filePath}}" />'
//                    }
//                  }
//                }
            },
            build: {
                src: [
                  '<%= yeoman.app %>/index.html'
                ]
                // ],
                // ignorePath: '../../',
                // fileTypes: {
                //   html: {
                //     replace: {
                //       js: '<script src="frontend_src/app/{{filePath}}"></script>',
                //       css: '<link rel="stylesheet" href="frontend_src/app/{{filePath}}" />'
                //     }
                //   }
                // }
            }
        },

        // Compiles CoffeeScript to JavaScript
        coffee: {
            options: {
                sourceMap: true,
                sourceRoot: ''
            },
            dist: {
                options: {
                  sourceMap: false
                },
                files: [
                    {
                        expand: true,
                        cwd: '<%= yeoman.app %>/scripts',
                        src: '{,*/}*.coffee',
                        dest: '.tmp/static/scripts',
                        ext: '.js'
                    }
                ]
            },
            dev: {
                files: [
                    {
                        expand: true,
                        cwd: '<%= yeoman.app %>/scripts',
                        src: '{,*/}*.coffee',
                        dest: '<%= yeoman.dist %>/scripts',
                        ext: '.js'
                    }
                ]
            }
        },

        // Renames files for browser caching purposes
        rev: {
            dist: {
                files: {
                    src: [
                      '<%= yeoman.build %>/static/scripts/{,*/}*.js',
                      '<%= yeoman.build %>/static/styles/{,*/}*.css'
//                        '<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}',
//                        '<%= yeoman.dist %>/styles/fonts/*'
                    ]
                }
            }
        },

        // Reads HTML for usemin blocks to enable smart builds that automatically
        // concat, minify and revision files. Creates configurations in memory so
        // additional tasks can operate on them
        useminPrepare: {
            dist: {
              src: [
              // '<%= yeoman.app %>/django_templates/base/layout.html',
              '<%= yeoman.app %>/index.html'
            ]},
            options: {
                dest: '<%= yeoman.build %>',
                flow: {
                    dist: {
                        steps: {
                            js: ['concat'], //, 'uglifyjs'],
                            css: ['cssmin']
                        },
                        post: {}
                    }
                }
            }
        },

        // Performs rewrites based on rev and the useminPrepare configuration
        usemin: {
            html: [
              '<%= yeoman.build %>/{,*/}*.html',
              '<%= yeoman.build %>/{,*/*/}*.html'
            ],
            css: ['<%= yeoman.build %>/styles/{,*/}*.css'],
            // js: ['<%= yeoman.build %>/static/scripts/{,*/}*.js'],
            options: {
                assetsDirs: ['<%= yeoman.build %>']
            }
        },

        // The following *-min tasks produce minified files in the dist folder
        cssmin: {
            options: {
                root: '<%= yeoman.build %>'
            }
        },

        // ngmin tries to make the code safe for minification automatically by
        // using the Angular long form for dependency injection. It doesn't work on
        // things like resolve or inject so those have to be done manually.
        ngmin: {
            dist: {
                files: [
                    {
                        expand: true,
                        cwd: '<%= yeoman.dist %>/scripts',
                        src: '*.js',
                        dest: '<%= yeoman.dist %>/scripts'
                    }
                ]
            }
        },

        // Replace Google CDN references
        cdnify: {
            dist: {
                html: ['<%= yeoman.build %>/*.html']
            }
        },

        // Copies remaining files to places other tasks can use
        copy: {
            dev: {
                files: [
                    {
                        expand: true,
                        dot: true,
                        cwd: '<%= yeoman.app %>',
                        dest: '<%= yeoman.dist %>',
                        src: [
                            '*.{ico,png,txt}',
                            '.htaccess',
                            '*.html',
                            'views/**/**/*.html',
                            'images/**/*',
                            'fonts/*',
                            'lib/**/*',
                            'js/**/*',
                            'css/**/*'
                        ]
                    },
                    {
                        expand: true,
                        dot: true,
                        src: [
                            'bower/**/*',
                            'libs/**/*'
                        ],
                        dest: '<%= yeoman.dist %>'
                    }
                ]
            },
            styles: {
                expand: true,
                cwd: '<%= yeoman.app %>/styles',
                dest: '.tmp/static/styles/',
                src: '{,*/}*.css'
            },
            dev_styles: {
                expand: true,
                cwd: '<%= yeoman.app %>/styles',
                dest: '<%= yeoman.dist %>/styles/',
                src: '{,*/}*.css'
            }
        },

        // Run some tasks in parallel to speed up the build process
        concurrent: {
            test: [
                'coffee',
                'copy:dev_styles'
            ],
            dev: [
                'coffee:dev',
                'stylus:dev',
                'copy:dev_styles'
            ],
            dist: [
                'coffee:dist',
                'stylus:dist',
                'copy:styles'
//                'imagemin',
//                'svgmin'
            ]
        },

        // Stylus CSS preprocessing and compilation
        stylus: {
            dev: {
                files: {
                    '<%= yeoman.dist %>/styles/main.css': '<%= yeoman.app %>/styles/main.styl' // 1:1 compile
                }
            },
            dist: {
                files: {
                    '.tmp/static/styles/main.css': '<%= yeoman.app %>/styles/main.styl' // 1:1 compile
                }
            }

        },

        //////////////
        // Deployment - shell commands
        shell: {
            options: {
                stdout: true,
                stderr: true
            },
            fab_copy_testing: {
              command: "cd ./scripts/deploy/; fab copy_files_testing"
            },
            fab_deploy_testing: {
              command: "cd ./scripts/deploy/; fab deploy_testing"
            }
        }
    });


    grunt.registerTask('build', [
        'clean:dist',
        'bowerInstall:build',
        'useminPrepare',
        'concurrent:dist',
        'autoprefixer:dist',
        'concat',
        // TODO: enable this after gruntfile works fine
        // 'ngmin:dist',
        'copy:dist',
        // 'cdnify',
        'cssmin',
        //'uglify',
        'rev',
        'usemin',
//        'htmlmin',
        'copy:www'
    ]);

    grunt.registerTask('dev', [
        'clean:dev',
        'bowerInstall:app',
        'concurrent:dev',
        'copy:dev',
        'watch'
    ]);


};
