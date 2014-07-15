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
    <td><tt>[:farnsworth][]</tt></td>
    <td></td>
    <td></td>
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
    <tr>
    <td><tt>[:farnsworth][]</tt></td>
    <td></td>
    <td></td>
  </tr>
</table>

Usage
-----
#### farnsworth::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `farnsworth` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[farnsworth]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Nicholas Herson

Thanks to Nader Morshed and Karandeep Singh Nagra for developing Farnsworth
