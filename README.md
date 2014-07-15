Farnsworth Cookbook
===================
A cookbook to setup Farnsworth, the upcoming house-level BSC website.

For more information about Farnsworth itself can be found [here](https://github.com/knagra/farnsworth)


Requirements
------------
This cookbook depends on the following cookbooks:
- python
- java
- database
- elasticsearch
- apache2
- selinux
- application_python

This cookbook (when complete) should work on Ubuntu and CentOS.

Attributes and Data Bags
----------

#### farnsworth::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>[:farnsworth][:house_name]</tt></td>
    <td>String</td>
    <td>Full name of house, e.g. Davis House</td>
  </tr>  
    <tr>
    <td><tt>[:farnsworth][:short_house_name]</tt></td>
    <td>String</td>
    <td>Shortened name of house, e.g. Davis</td>
  </tr>
    <tr>
    <td><tt>[:farnsworth][:house_abbrev]</tt></td>
    <td>String</td>
    <td>3 letter abbreviation of house name, e.g. dav</td>
  </tr>
    <tr>
    <td><tt>[:farnsworth][:site_domain]</tt></td>
    <td>String</td>
    <td>Domain of site, e.g. www.davishouse.com</td>
  </tr>
    <tr>
    <td><tt>[:farnsworth][:enable_oauth]</tt></td>
    <td>Boolean</td>
    <td>Whether or not to use OAuth, defaults to false if omitted</td>
  </tr>
    <tr>
    <td><tt>[:farnsworth][:oauth_providers]</tt></td>
    <td>Array (Strings)</td>
    <td>List of providers to use w/ OAuth, e.g. ['facebook','google']</td>
  </tr>
    <tr>
    <td><tt>[:farnsworth][:repo]</tt></td>
    <td>String</td>
    <td>URL from which to fetch the Farnsworth app</td>
  </tr>
    <tr>
    <td><tt>[:farnsworth][:key_path]</tt></td>
    <td>String</td>
    <td>Path on host to find the encrypted data bag secret, default: '/etc/chef/keys/farnsworth_private.key'</td>
  </tr>
    <tr>
    <td><tt>[:farnsworth][:site_root]</tt></td>
    <td>String</td>
    <td>Base path to install the app into, e.g. /usr/local/farnsworth</td>
  </tr>
</table>

An encrypted data bag is needed for use with this cookbook.  The data bag should be called `farnsworth`, and the data bag item within it should be named `private`. The following keys need to be defined:

<table>
  <tr>
    <th>Key Name</th>
    <th>Description</th>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td><tt>postgres_password</tt></td>
    <td>Password to access the database as the admin user (you define this, the cookbook sets it)</td>
  </tr>
  <tr>
    <td><tt>secret_key</tt></td>
    <td>Some long string of your choosing (try `openssl rand -base64 50`)</tt></td>
  </tr>
  <tr>
    <td><tt>network_manager_password</tt></td>
    <td>Password to the XXXnm@bsc.coop e-mail address</td>
  </tr>
</table>

Usage
-----
#### farnsworth::default

Include `farnsworth` in your node's `run_list`. That should be all!


TODO
----
- Implement an attribute to choose either `nginx` or `apache`.
- Allow specifying the exact data bag and item names in which private bits are stored

License and Authors
-------------------
Authors: Nicholas Herson

Thanks to Nader Morshed and Karandeep Singh Nagra for developing Farnsworth
