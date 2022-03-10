onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Prescaler25_opt

do {wave.do}

view wave
view structure
view signals

do {Prescaler25.udo}

run -all

quit -force
