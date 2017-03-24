class profile::base::windows(
  Optional[Array] $packages = lookup('profile::base::windows::packages', 'unique', undef),
  Integer $ie_esc_users = 1,
  Integer $ie_esc_admins = 0,
) {

  # Base configuration for windows

  # Set default Powershell Execution Policy to RemoteSigned.
  registry::value { 'PowerShell execution policy':
    key   => 'HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell',
    value => 'ExecutionPolicy',
    type  => string,
    data  => 'RemoteSigned',
  }

  # Packages
  include chocolatey
  package { $packages:
    ensure   => present,
    provider => chocolatey,
  }

  # Configure IE ESC for Users and Administrators
  #   Default: On for Users, Off for Administrators group members.
  registry::value { 'IE ESC for Users':
    key   => 'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}',
    value => 'IsInstalled',
    type  => dword,
    data  => $ie_esc_users,
  }
  registry::value { 'IE ESC for Administrators':
    key   => 'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}',
    value => 'IsInstalled',
    type  => dword,
    data  => $ie_esc_admins,
  }

}
