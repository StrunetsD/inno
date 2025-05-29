import { gsap } from 'gsap'
import MorphSVGPlugin from './MorphSVGPlugin'

if (MorphSVGPlugin) gsap.registerPlugin(MorphSVGPlugin)

export default function FaveAnimation(myDiv) {
    var mainTl;
    var purplePopTl;
    var redPopTl;
    var heartTl;
    var allPopTl;
    var greenPopTl;
    var yellowPopTl;
    var bluePopTl;
    var redPop2Tl;
    var redPop3Tl;;
    var redPop3 = myDiv.querySelector('.redPop3');
    var redPop2 = myDiv.querySelector('.redPop2');
  var bluePop = myDiv.querySelector('.bluePop');
  var yellowPop = myDiv.querySelector('.yellowPop');
  var purplePop = myDiv.querySelector('.purplePop');
  var greenPop = myDiv.querySelector('.greenPop');
  var redPop = myDiv.querySelector('.redPop');
  var outline = myDiv.querySelector('.outline');
  var heart = myDiv.querySelector('.heart');

    this.init = function() {

        gsap.set([outline, heart], {
            // transformOrigin: '50% 50%',
            svgOrigin: "300 300"
        })

        allPopTl = gsap.timeline().timeScale(1);

        redPop2Tl = gsap.timeline({}).timeScale(1);
        redPop3Tl = gsap.timeline({}).timeScale(1);
        bluePopTl = gsap.timeline({}).timeScale(1);
        yellowPopTl = gsap.timeline({}).timeScale(1);
        greenPopTl = gsap.timeline({}).timeScale(1);
        purplePopTl = gsap.timeline({}).timeScale(1);
        redPopTl = gsap.timeline({}).timeScale(1);
        heartTl = gsap.timeline({}).timeScale(1);
        mainTl = gsap.timeline({ paused: true }).timeScale(1.6);

        mainTl.addLabel('clickFave')
            .to(outline, 0.2, {
                scale: 0.9,
                ease:  'none'
            })
            .to(outline, 0.2, {
                scale: 1,
                ease:  'none'
            })
            .set(outline, {
                autoAlpha: 0,
                scale: 0.7
            }, '-=0')
            .from(heart, 1, {
                scale: 0,
                fill: '#f638a8',
                ease: 'elastic(1.5, 0.7)',
            }, '-=0.34')

            .addLabel('setFave')
            .addPause()
            .addLabel('clickUnfave')
            .set(outline, {
                autoAlpha: 1
            })
            .to(heart, 0.4, {
                scale: 0
            })
            .to(heart, 0.1, {
                fill: '#b4b4b4',
                stroke: '#b4b4b4'
            }, '-=0.4')
            .to(outline, 1, {
                scale: 1,
                ease: 'elastic(1.5, 0.7)',
            }, '-=0.3')
            .addLabel('setUnfave')

        //POPS
        purplePopTl.fromTo(purplePop, 0.4, {
                attr: {
                    r: 0
                }
            }, {
                attr: {
                    r: 100
                },
                ease:  'power1.out'
            })
            .from(purplePop, 0.6, {
                strokeWidth: 23,
                ease:  'power3.inOut'
            }, '-=0.4')
            .to(purplePop, 0.2, {
                attr: {
                    r: 110
                },
                ease:  'power3.out'
            }, '-=0.2 ')

        redPopTl.fromTo(redPop, 0.4, {
                attr: {
                    r: 0
                }
            }, {
                attr: {
                    r: 100
                },
                ease:  'power1.out'
            })
            .from(redPop, 0.6, {
                strokeWidth: 23,
                ease:  'power3.inOut'
            }, '-=0.4')
            .to(redPop, 0.2, {
                attr: {
                    r: 110
                },
                ease:  'power3.out'
            }, '-=0.2 ')


        greenPopTl.fromTo(greenPop, 0.4, {
                attr: {
                    r: 0
                }
            }, {
                attr: {
                    r: 100
                },
                ease:  'power1.out'
            })
            .from(greenPop, 0.6, {
                strokeWidth: 23,
                ease:  'power3.inOut'
            }, '-=0.4')
            .to(greenPop, 0.2, {
                attr: {
                    r: 110
                },
                ease:  'power3.out'
            }, '-=0.2 ')

        yellowPopTl.fromTo(yellowPop, 0.4, {
                attr: {
                    r: 0
                }
            }, {
                attr: {
                    r: 100
                },
                ease:  'power1.out'
            })
            .from(yellowPop, 0.6, {
                strokeWidth: 23,
                ease:  'power3.inOut'
            }, '-=0.4')
            .to(yellowPop, 0.2, {
                attr: {
                    r: 110
                },
                ease:  'power3.out'
            }, '-=0.2 ')

        bluePopTl.fromTo(bluePop, 0.4, {
                attr: {
                    r: 0
                }
            }, {
                attr: {
                    r: 100
                },
                ease:  'power1.out'
            })
            .from(bluePop, 0.6, {
                strokeWidth: 23,
                ease:  'power3.inOut'
            }, '-=0.4')
            .to(bluePop, 0.2, {
                attr: {
                    r: 110
                },
                ease:  'power3.out'
            }, '-=0.2 ')

        redPop2Tl.fromTo(redPop2, 0.4, {
                attr: {
                    r: 0
                }
            }, {
                attr: {
                    r: 100
                },
                ease:  'power1.out'
            })
            .from(redPop2, 0.6, {
                strokeWidth: 23,
                ease:  'power3.inOut'
            }, '-=0.4')
            .to(redPop2, 0.2, {
                attr: {
                    r: 110
                },
                ease:  'power3.out'
            }, '-=0.2 ')

        redPop3Tl.fromTo(redPop3, 0.4, {
                attr: {
                    r: 0
                }
            }, {
                attr: {
                    r: 100
                },
                ease:  'power1.out'
            })
            .from(redPop3, 0.6, {
                strokeWidth: 23,
                ease:  'power3.inOut'
            }, '-=0.4')
            .to(redPop3, 0.2, {
                attr: {
                    r: 110
                },
                ease:  'power3.out'
            }, '-=0.2 ');

        allPopTl.add(redPopTl)
            .add(purplePopTl, '-=0.56')
            .add(yellowPopTl, '-=0.5')
            .add(bluePopTl, '-=0.55')
            .add(greenPopTl, '-=0.55')
            .add(redPop2Tl, '-=0.7')
            .add(redPop3Tl, '-=0.55')

        mainTl.add(allPopTl, 0.16);
    }

    this.clickFave = function() {
        mainTl.play('clickFave');
    }
    this.clickUnfave = function() {
        mainTl.play('clickUnfave');
    }
    this.setFave = function() {
        mainTl.pause('setFave');
    }
    this.setUnfave = function() {
        mainTl.pause('setUnfave');
    }
}
