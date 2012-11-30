Import('MODE')
Import('ARCH')
myTarget = 'testWeb'
myDsource = [Glob('src/*.d'), Glob('src/*/*.d')]
myLibs = ['phobos2','m','pthread','rt','pq','ssl']

env = Environment()
env.Append(DFLAGS = '-Isrc/')
env.Append(LINKFLAGS = ['-Xlinker'])
if (MODE == 'release'):
    env.Append(DFLAGS = ['-release'])
else:
    env.Append(DFLAGS = ['-w', '-version=embedded_httpd', '-debug', '-unittest'])

if (ARCH == '32'):
    #env.Append(DFLAGS = ['-m32'])
    myLibpath = ['/usr/lib']
else:
    myLibpath = ['/usr/lib64','/usr/lib']
myLibpath = ['/usr/lib64','/usr/lib']

t = env.Program(target=myTarget, 
                source=myDsource,
                LIBPATH= myLibpath,
                LIBS=myLibs)
print MODE
Default(t)
