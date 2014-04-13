package HW6;

import javax.persistence.*;
import javax.xml.bind.*;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import java.io.*;
import java.util.*;

/**
 * Created by tlunter on 4/4/14.
 */
public class SiteDao {
    EntityManagerFactory factory = Persistence.createEntityManagerFactory("HW6");

    public Site findSite(int siteId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Site site = em.find(Site.class, siteId);

        em.getTransaction().commit();
        em.close();

        return site;
    }

    public List<Site> getAllSites() {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Query query = em.createNamedQuery("Site.findAllSites");
        List<Site> sites = (List<Site>)query.getResultList();

        em.getTransaction().commit();
        em.close();

        return sites;
    }

    public void exportSitesToXmlFile(Sites sites, String xmlFileName) {
        File xmlFile = new File(xmlFileName);
        try {
            JAXBContext jaxb = JAXBContext.newInstance(Sites.class);
            Marshaller marshaller = jaxb.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            marshaller.marshal(sites, xmlFile);
        } catch (JAXBException e) {
            e.printStackTrace();
        }
    }

    public void convertXmlFileToOutputFile(String inputXmlFileName, String outputXmlFileName, String xsltFileName) {
        File inputXmlFile = new File(inputXmlFileName);
        File outputXmlFile = new File(outputXmlFileName);
        File xsltFile = new File(xsltFileName);

        StreamSource input = new StreamSource(inputXmlFile);
        StreamSource xslt = new StreamSource(xsltFile);
        StreamResult output = new StreamResult(outputXmlFile);

        TransformerFactory factory = TransformerFactory.newInstance();
        try {
            Transformer transformer = factory.newTransformer(xslt);
            transformer.transform(input, output);
        } catch (TransformerConfigurationException e) {
            e.printStackTrace();
        } catch (TransformerException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        SiteDao dao = new SiteDao();

        List<Site> sitesList = dao.getAllSites();

        Sites sites = new Sites(sitesList);

        dao.exportSitesToXmlFile(sites, "xml/sites.xml");
        dao.convertXmlFileToOutputFile("xml/sites.xml", "xml/sites.html", "xml/sites2html.xslt");
        dao.convertXmlFileToOutputFile("xml/sites.xml", "xml/equipments.html", "xml/sites2equipment.xslt");
    }
}
