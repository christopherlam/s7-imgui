(autoload 'aod.ns "aod/ns.scm")
(autoload 'aod.clj "aod/clj.scm")
(autoload 'aod.test "aod/test.scm")
(autoload 'aod.geom "aod/geom.scm")
(autoload 'aod.layout "aod/layout.scm")
(autoload 'aod.string "aod/string.scm")
(autoload 'aod.io "aod/io.scm")
(autoload 'imgui-macros.scm
	  ;; fuck, the lambda is not working
	  ;; aaaagggh
	  
	  ;; (lambda (e)
	  ;; (display "WARNING! please use aod.imgui.macros")
	  ;;   (unless (provided? 'imgui-macros)
	  ;;     (load "aod/imgui_macros.scm")))
	  "aod/imgui_macros.scm"
	  )
(autoload 'aod.imgui.macros "aod/imgui/macros.scm")
(autoload 'aod.colors "aod/colors.scm")
(autoload 'aod.midi "aod/midi.scm")
(autoload 'aod.imgui.helpers "aod/imgui/helpers.scm")
(autoload 'aod.sxs "aod/sxs.scm")
(autoload 'debug.scm "s7/debug.scm")
(autoload 'aod.benchmark "aod/benchmark.scm")
(autoload 'aod.scales "aod/scales.scm")
;; gui Components
(autoload 'aod.components.sxs-wheel "aod/components/sxs-wheel.scm")
(autoload 'aod.components.piano-wheel "aod/components/piano-wheel.scm")
(autoload 'aod.components.input "aod/components/input.scm")
