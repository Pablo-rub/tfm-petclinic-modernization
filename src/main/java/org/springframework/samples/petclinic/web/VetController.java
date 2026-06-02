/*
 * Copyright 2002-2022 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.springframework.samples.petclinic.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.samples.petclinic.model.Vet;
import org.springframework.samples.petclinic.model.Vets;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;

/**
 * @author Juergen Hoeller
 * @author Mark Fisher
 * @author Ken Krebs
 * @author Arjen Poutsma
 */
@Controller
public class VetController {

    private final RestTemplate restTemplate;
    private final String vetsServiceUrl;

    @Autowired
    public VetController(RestTemplate restTemplate, @Qualifier("vetsServiceUrl") String vetsServiceUrl) {
        this.restTemplate = restTemplate;
        this.vetsServiceUrl = vetsServiceUrl;
    }

    @GetMapping("/vets")
    public String showVetList(Map<String, Object> model) {
        Vets vets = getVets();
        model.put("vets", vets);
        return "vets/vetList";
    }

    @GetMapping(value = "/vets.json", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Vets showJsonVetList() {
        return getVets();
    }

    @GetMapping(value = "/vets.xml", produces = MediaType.APPLICATION_XML_VALUE)
    @ResponseBody
    public Vets showXmlVetList() {
        return getVets();
    }

    private Vets getVets() {
        List<Vet> vetList = restTemplate.exchange(
            vetsServiceUrl + "/api/vets",
            HttpMethod.GET,
            null,
            new ParameterizedTypeReference<List<Vet>>() {}
        ).getBody();

        Vets vets = new Vets();
        if (vetList != null) {
            vets.getVetList().addAll(vetList);
        }
        return vets;
    }
}
