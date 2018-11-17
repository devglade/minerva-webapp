module.exports = function (grunt) {
    require('load-grunt-tasks')(grunt);

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        svgmin: {
            dist: {
                files: [{
                    expand: true,
                    cwd: 'app/assets/svgs/icons',
                    src: ['*.svg'],
                    dest: 'app/assets/svgs/gen'
                }]
            },
            options: {
                plugins: [
                    {removeViewBox: false},               // don't remove the viewbox attribute from the SVG
                    {removeUselessStrokeAndFill: false},  // don't remove Useless Strokes and Fills
                    {removeEmptyAttrs: false}             // don't remove Empty Attributes from the SVG
                ]
            }
        },
        svgstore: {
            dist: {
                files: {
                    'app/assets/svgs/svg-defs.svg': ['app/assets/svgs/gen/*.svg']
                },
            },
            options: {
                cleanup: ['fill']
            }
        },
        svg2png: {
            dist: {
                files: [{
                    flatten: true,
                    cwd: 'app/assets/svgs/gen/',
                    src: ['*.svg'],
                    dest: 'app/assets/images/gen/'
                }
                ]
            }
        },
    });
    grunt.registerTask('default', ['svgmin', 'svgstore', 'svg2png']);
};
