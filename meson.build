project('s7-imgui', 'cpp', 'c',
       )

extra_args = []
if meson.get_compiler('cpp').get_id() == 'msvc'
  message('visual studio')
  # examples flags from the provided example
  extra_args += ['/wd"4996"', '/wd"4250"', '/wd"4018"', '/wd"4267"', '/wd"4068"', '-D_DEBUG']
endif

subdir('src')

link_args = []

system = host_machine.system()
if system == 'windows'
  # just copied that from the provided examples
  link_args += '/DYNAMICBASE "dsound.lib" "winmm.lib" "wininet.lib" "comctl32.lib" "Shlwapi.lib" "kernel32.lib" "user32.lib" "gdi32.lib" "winspool.lib" "comdlg32.lib" "advapi32.lib" "shell32.lib" "ole32.lib" "oleaut32.lib" "uuid.lib" "odbc32.lib" "odbccp32.lib"'
  link_args += '/TLBID:1'

  # so turns out that imgui subproject builds a library
  # and it has to be linked against opengl32.lib
  # it dones't just work if I add this link arg in my vst/exe target
  add_global_link_arguments('/DYNAMICBASE "opengl32.lib"', language: 'cpp')
elif system == 'linux'
  link_args += ['-lpthread',
		'-lxcb',
		'-ldl',
		'-lGL',
		'-lfontconfig',
		# '-lGLU',
		'-lpulse',
		'-lpulse-simple',
	       ]
  # needed for compiling subprojects/imgui-1.76/examples/imgui_impl_opengl2.cpp
  add_global_link_arguments('-lGL', language: 'cpp')
  extra_args += ['-fpermissive']
endif

sdl2_proj = subproject('sdl2')
sdl2_dep = sdl2_proj.get_variable('sdl2_dep')

# imgui searched for sdl
# https://mesonbuild.com/Reference-manual.html#dependency
meson.override_dependency('sdl', sdl2_dep)

s7_proj = subproject('s7')
s7_dep = s7_proj.get_variable('s7_dep')

imgui = subproject('imgui',
		   default_options: ['sdl=enabled',
				     'opengl2=enabled',
				    ])
imgui_dep = imgui.get_variable('imgui_dep')

app = executable(
  's7-imgui',
  dependencies : [
    app_dep,
    sdl2_dep,
    imgui_dep,
    s7_dep,
  ],
  link_args: link_args,
  cpp_args: extra_args,
  install: true,
)