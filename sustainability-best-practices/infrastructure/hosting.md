# Hosting

## Hosting - renewable and low-carbon energy

All major cloud providers have committed to using renewable energy sources for their power needs. Some providers are going further and committing to more responsible utilization/recycling of water - this is a big deal, given the cooling requirements of data centers. Using a hosting provider that is powered by renewable will make a difference.

The Green Web Foundation has a [published list of green hosts](https://www.thegreenwebfoundation.org/tools/directory/).

## SaaS/PaaS vs IaaS & On-prem

Using **Software as a Service (SaaS) services** means you are offloading responsibility for a service to a third party so choose wisely. Use providers who can show they are using renewable energy and have committed to using reneewable energy and other sustainablity best practices. The best providers will balance the load on the underlying infrastructure so that overall utilization is high and they don’t have idle servers.

**Infrastructure as a Service (IaaS)** is another option, typically in the form of Virtual Machines (VM) and other infrastructure in the cloud. This option means you have to deal with the overhead of running a VM, including patching and other operational concerns. This way, it can be difficult to ensure that `hardware` is fully utilized. Idling or non-efficient use of hardware means energy being used that isn’t doing effective work. Considering technology like Kubernetes may help with this.

**On-prem** should be avoided unless necessary as you do not benefit from the economy of scale of using a cloud provider. You are entirely responsible for operational maintenance (including patching, hardware, networking, fire suppression, cooling, security, etc). You also have the same problem of maximizing utilization as you do with IaaS. Some use cases may mandate/require on-prem - but if yours doesn’t, avoid it.

## Cloud Native

Cloud Native is an important topic. The focus is on using cloud services and modern tools and approaches to enable you to deliver services with speed and agility. A happy byproduct is that it will likely make efficient use of the resources you employ (lowering your footprint). And as we’ve already covered, leveraging cloud services is highly likely to be consuming renewable energy.

## Scale based on requirements, only use what’s needed

Don’t overprovision your systems. Use metrics/telemetry/tooling to identify if you’re massively oversized for your use cases. Do you need that cloud service to be running at 20% capacity all the time? Make use of autoscaling, serverless technology, and SaaS services.

## Turn off resources when not in use, for example, dev/staging sites

If you’ve got provisioned infrastructure sitting around at the weekend and your teams don’t work at the weekend then remove it. It’s a good excuse to adopt practices such as infrastructure-as-code. You will have repeatable, more reliable infrastructure, and you’ll be able to create and remove new environments with ease.
