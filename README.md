# Ansible Role: Common

Provisions Arch Linux and Arch Linux ARM hosts:

- General system setup
- Install packages (including AUR packages)
- Add users and groups
- Configure network
- Security configuration
- Starting and enabling system services

## Requirements

To install Arch Linux packages, this role relies on the pacman module of the community general collection. Install it with `ansible-galaxy collection install community.general`.

Requires the `ansible-aur` module for installing AUR packages on hosts. See the [ansible-aur](https://github.com/kewlfft/ansible-aur) repository for installation instructions.

## Role Variables

| Variable          | Choices/**Default**              | Comments                                                                                    |
| ----------------- | -------------------------------- | ------------------------------------------------------------------------------------------- |
| timezone          | **UTC**, …                       | The system timezone, list all possible values with the command `timedatectl list-timezones` |
| dracut            | true, **false**                  | Whether to utilize `dracut` instead of the default `mkinitcpio`                             |
| mirrors           | **[United States]**, …           | A list of countries from which mirrors should be selected.                                  |
| arch              | **auto**, armv6h, armv7h, armv8h | Machine architecture, defaults to `auto` for x86_64, but must be changed for ARM machines   |
| packages          | **[]**, …                        | List of packages to install                                                                 |
| packages_aur      | **[]**, …                        | List of AUR packages to install                                                             |
| xdg               | true, **false**                  | Set XDG directory defaults (according to files/user-dirs.defaults)                          |
| groups            | **[]**, …                        | List of groups to create                                                                    |
| sudoers           | **[]**, …                        | List of groups that will receive passwordless sudo access                                   |
| sshusers          | **[]**, …                        | List of groups that will receive SSH access                                                 |
| users             | **[]**, …                        | List of users to add, see below this table for the expected format                          |
| ethernet          | **true**, false                  | Whether to set up an ethernet network configuration                                         |
| wlan              | true, **false**                  | Whether to set up a wireless network configuration                                          |
| wwan              | true, **false**                  | Whether to set up a WAN network configuration                                               |
| bridge            | true, **false**                  | Whether to set up a network bridge interface                                                |
| bridge_interfaces | **[]**, …                        | Which network interfaces to bridge (requires above option to be true)                       |
| firewall_tcp      | **[]**, …                        | List of TCP ports to allow in the firewall                                                  |
| firewall_udp      | **[]**, …                        | List of UDP ports to allow in the firewall                                                  |
| dns               | **[]**, …                        | List of DNS primary addresses                                                               |
| dns_fallback      | **[]**, …                        | List of DNS fallback addresses                                                              |
| ntp               | **[]**, …                        | List of NTP primary addresses                                                               |
| ntp_fallback      | **[]**, …                        | List of NTP fallback addresses                                                              |
| services          | **[]**, …                        | List of system services (systemd services, timers, …) to start now and enable on boot       |

User declarations are in the following format. Note that passwords are defined using the [pass](https://www.passwordstore.org/) utility and the respective Ansible [passwordstore](https://docs.ansible.com/ansible/latest/plugins/lookup/passwordstore.html) plugin.

    users:
    - name: root
        pass: path/to/pass/root
    - name: myuser
        pass: path/to/pass/myuser
        shell: /bin/bash
        groups:
        - audio
        - video
        - wheel
        pubkey: "MY_PUBLIC_KEY"

## Dependencies

None.

## Example Playbook

    - hosts: all
      become: true
      roles:
         - ansible-role-common

## License

Ansible-role-common is licensed under the [MIT license](LICENSE).
