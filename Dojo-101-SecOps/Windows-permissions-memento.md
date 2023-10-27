# permissions memento

   permission is a permission mask and can be specified in one of two forms:
        a sequence of simple rights:
                D - Delete access
                F - Full access (Edit_Permissions+Create+Delete+Read+Write)
                N - No access
                M - Modify access (Create+Delete+Read+Write)
                RX - Read and eXecute access
                R - Read-only access
                W - Write-only access
        a comma-separated list in parentheses of specific rights:
                DE - Delete
                RC - read control
                WDAC - write DAC
                WO - write owner
                S - synchronize
                AS - access system security
                MA - maximum allowed
                GR - generic read
                GW - generic write
                GE - generic execute
                GA - generic all
                RD - read data/list directory
                WD - write data/add file
                AD - append data/add subdirectory
                REA - read extended attributes
                WEA - write extended attributes
                X - execute/traverse
                DC - delete child
                RA - read attributes
                WA - write attributes
        inheritance rights can precede either form and are applied
        only to directories:
                (OI) - object inherit
                (CI) - container inherit
                (IO) - inherit only
                (NP) - don’t propagate inherit
                (I)  - Permission inherited from parent container

