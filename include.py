#! /usr/bin/env python

# Thanks fam
# https://github.com/cezarywojcik/Swift-Script-Include

#-----------------------------------------------------------------------------#
# Name: include.py
# Desc: Replaces 'include "file.swift"' statements with the actual
#       file contents.
# Auth: Cezary Wojcik
# Opts: -i, --inputfile     : specify input file (default "main.swift")
#       -o, --outputfile    : specify output file (default "app.swift")
#       -d, --debug         : show debug messages
#-----------------------------------------------------------------------------#

# ---- [ imports ] ------------------------------------------------------------

import getopt, sys, re

# ---- [ globals ] ------------------------------------------------------------

includedFileNames = []

# ---- [ utility functions ] --------------------------------------------------

def absoluteFilePath(relativePath):

    path = sys.path[0]
    return path + "/src/" + relativePath

def handleError(message):

    print "Error: {0}".format(message)
    sys.exit(2)

# ---- [ helper functions ] ---------------------------------------------------

def includify(file):

    global includedFileNames
    includedFileNames.append(file)

    output = ""
    pattern = re.compile("include \"(.*)\"")

    with open(file) as f:

        arr = f.readlines()

        for line in arr:

            match = pattern.match(line)

            if match:

                name = match.group(1) # => "source.swift"
                path = absoluteFilePath(name) # => "../src/source.swift" (based on this scripts path)

                if name not in includedFileNames:
                    output += includify(path)

            else:
                output += line

    return output

# ---- [ main ] ---------------------------------------------------------------

def main(argv):

    inputFile = "main.swift"
    outputfile = "app.swift"

    try:
        opts, args = getopt.getopt(sys.argv[1:], 'i:o:', ['inputfile=', 'outputfile='])
    except getopt.GetoptError as err:
        handleError(str(err))

    for o, a in opts:

        if o in ['-i', '--inputfile']:
            inputfile = a
        elif o in ['-o', '--outputfile']:
            outputfile = a
        else:
            handleError("unhandled option '{0}' detected".format(o))

    # Create output file

    try:
        file = open(outputfile, "w+")
        file.close()
    except IOError:
        handleError("failed to open output file, '{0}'."
        .format(benchmarkfile))

    # Parse input file

    file = open(outputfile, "w")
    file.write(includify(inputfile))

if __name__ == "__main__":
    main(sys.argv[1:])
