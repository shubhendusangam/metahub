package com.metahub.event;

import com.metahub.model.Dataset;
import lombok.Getter;
import org.springframework.context.ApplicationEvent;

@Getter
public class MetadataChangeEvent extends ApplicationEvent {

    public enum Action { CREATED, UPDATED, DELETED }

    private final Dataset dataset;
    private final Action action;

    public MetadataChangeEvent(Object source, Dataset dataset, Action action) {
        super(source);
        this.dataset = dataset;
        this.action = action;
    }
}

