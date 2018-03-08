#!/usr/bin/env bash

#############################################################################
##
## Copyright (C) 2017 The Qt Company Ltd.
## Contact: http://www.qt.io/licensing/
##
## This file is part of the test suite of the Qt Toolkit.
##
## $QT_BEGIN_LICENSE:LGPL21$
## Commercial License Usage
## Licensees holding valid commercial Qt licenses may use this file in
## accordance with the commercial license agreement provided with the
## Software or, alternatively, in accordance with the terms contained in
## a written agreement between you and The Qt Company. For licensing terms
## and conditions see http://www.qt.io/terms-conditions. For further
## information use the contact form at http://www.qt.io/contact-us.
##
## GNU Lesser General Public License Usage
## Alternatively, this file may be used under the terms of the GNU Lesser
## General Public License version 2.1 or version 3 as published by the Free
## Software Foundation and appearing in the file LICENSE.LGPLv21 and
## LICENSE.LGPLv3 included in the packaging of this file. Please review the
## following information to ensure the GNU Lesser General Public License
## requirements will be met: https://www.gnu.org/licenses/lgpl.html and
## http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
##
## As a special exception, The Qt Company gives you certain additional
## rights. These rights are described in The Qt Company LGPL Exception
## version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
##
## $QT_END_LICENSE$
##
#############################################################################
source "${BASH_SOURCE%/*}/../unix/DownloadURL.sh"
set -ex

# Command line tools is need by homebrew

function InstallCommandLineTools {
    url=$1
    url_alt=$2
    expectedSha1=$3
    packageName=$4
    version=$5

    DownloadURL $url $url_alt $expectedSha1 /tmp/$packageName
    echo "Mounting $packageName"
    hdiutil attach /tmp/$packageName
    cd "/Volumes/Command Line Developer Tools"
    echo "Installing"
    sudo installer -verbose -pkg *.pkg -target /
    cd /
    # Let's fait for 5 second before unmounting. Sometimes resource is busy and cant be unmounted
    sleep 3
    echo "Unmounting"
    umount /Volumes/Command\ Line\ Developer\ Tools/
    echo "Removing $packageName"
    rm /tmp/$packageName

    echo "Command Line Tools = $version" >> ~/versions.txt
}
