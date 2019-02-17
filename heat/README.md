# Heat templates

These are Heat templates to launch the entire stack in monolithic and distributed versions.  
The servers gets their configuration based on the Puppet control repo (from the parent directory).

### Usage

Clone, config, and launch in OpenStack

```bash
git clone https://github.com/p3lim/tick-stack-conf.git
cd tick-stack-conf/heat
vi tick_env.yaml
openstack stack create tick -t tick.yaml -e tick_env.yaml
```
