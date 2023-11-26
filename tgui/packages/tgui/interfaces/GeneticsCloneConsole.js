import { round } from 'common/math';
import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Box, Button, Icon, LabeledList, NoticeBox, ProgressBar, Section, Tabs } from '../components';
import { ComplexModal, modalRegisterBodyOverride } from '../interfaces/common/ComplexModal';
import { Window } from '../layouts';

const MENU_MAIN = 1;

const viewMindRecordModalBodyOverride = (modal, context) => {
  const { act, data } = useBackend(context);
  const { activerecord, realname, obviously_dead, oocnotes, can_sleeve_active } = modal.args;
  return (
    <Section
      level={2}
      m="-1rem"
      pb="1rem"
      title={'Mind Record (' + realname + ')'}
      buttons={<Button icon="times" color="red" onClick={() => act('modal_close')} />}>
      <LabeledList>
        <LabeledList.Item label="Name">{realname}</LabeledList.Item>
        <LabeledList.Item label="Status">{obviously_dead}</LabeledList.Item>
        <LabeledList.Item label="Actions">
          <Button
            disabled={!can_sleeve_active}
            icon="user-plus"
            content="Sleeve"
            onClick={() =>
              act('sleeve', {
                ref: activerecord,
                mode: 1,
              })
            }
          />
        </LabeledList.Item>
        <LabeledList.Item label="OOC Notes">
          <Section style={{ 'word-break': 'break-all', 'height': '100px' }} scrollable>
            {oocnotes}
          </Section>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const viewBodyRecordModalBodyOverride = (modal, context) => {
  const { act, data } = useBackend(context);
  const { activerecord, realname, species, sex, mind_compat, synthetic, oocnotes, can_grow_active } = modal.args;
  return (
    <Section
      level={2}
      m="-1rem"
      pb="1rem"
      title={'Body Record (' + realname + ')'}
      buttons={<Button icon="times" color="red" onClick={() => act('modal_close')} />}>
      <LabeledList>
        <LabeledList.Item label="Name">{realname}</LabeledList.Item>
        <LabeledList.Item label="Species">{species}</LabeledList.Item>
        <LabeledList.Item label="Bio. Sex">{sex}</LabeledList.Item>
        <LabeledList.Item label="Mind Compat">{mind_compat}</LabeledList.Item>
        <LabeledList.Item label="Synthetic">{synthetic ? 'Yes' : 'No'}</LabeledList.Item>
        <LabeledList.Item label="OOC Notes">
          <Section style={{ 'word-break': 'break-all', 'height': '100px' }} scrollable>
            {oocnotes}
          </Section>
        </LabeledList.Item>
        <LabeledList.Item label="Actions">
          <Button
            disabled={!can_grow_active}
            icon="user-plus"
            content={synthetic ? 'Build' : 'Grow'}
            onClick={() =>
              act('create', {
                ref: activerecord,
              })
            }
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

export const GeneticsCloneConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const { menu } = data;
  let body = (
    <Fragment>
      <GeneticsCloneConsoleTemp />
      <GeneticsCloneConsoleStatus />
      <GeneticsCloneConsoleNavigation />
      <Section noTopPadding flexGrow="1">
        <GeneticsCloneConsoleBody />
      </Section>
    </Fragment>
  );
  modalRegisterBodyOverride('view_b_rec', viewBodyRecordModalBodyOverride);
  modalRegisterBodyOverride('view_m_rec', viewMindRecordModalBodyOverride);
  return (
    <Window width={640} height={520} resizable>
      <ComplexModal maxWidth="75%" maxHeight="75%" />
      <Window.Content className="Layout__content--flexColumn">{body}</Window.Content>
    </Window>
  );
};

const GeneticsCloneConsoleNavigation = (props, context) => {
  const { act, data } = useBackend(context);
  const { menu } = data;
  return (
    <Tabs>
      <Tabs.Tab
        selected={menu === MENU_MAIN}
        icon="home"
        onClick={() =>
          act('menu', {
            num: MENU_MAIN,
          })
        }>
        Main
      </Tabs.Tab>
    </Tabs>
  );
};

const GeneticsCloneConsoleBody = (props, context) => {
  const { data } = useBackend(context);
  const { menu, bodyrecords, mindrecords } = data;
  let body;
  if (menu === MENU_MAIN) {
    body = <GeneticsCloneConsoleMain />;
  }
  return body;
};

const GeneticsCloneConsoleMain = (props, context) => {
  const { act, data } = useBackend(context);
  const { loading, scantemp, occupant, locked, can_brainscan, scan_mode, pods, selected_pod } = data;
  const isLocked = locked && !!occupant;
  return (
    <Section title="Pods" level="2">
      <GeneticsCloneConsolePodGrowers />
    </Section>
  );
};

const GeneticsCloneConsolePodGrowers = (props, context) => {
  const { act, data } = useBackend(context);
  const { pods, spods, selected_pod } = data;

  if (pods && pods.length) {
    return pods.map((pod, i) => {
      let podAction;
      if (pod.status === 'cloning') {
        podAction = (
          <ProgressBar
            min="0"
            max="100"
            value={pod.progress / 100}
            ranges={{
              good: [0.75, Infinity],
              average: [0.25, 0.75],
              bad: [-Infinity, 0.25],
            }}
            mt="0.5rem">
            <Box textAlign="center">{round(pod.progress, 0) + '%'}</Box>
          </ProgressBar>
        );
      } else if (pod.status === 'mess') {
        podAction = (
          <Box bold color="bad" mt="0.5rem">
            ERROR
          </Box>
        );
      } else {
        podAction = (
          <Button
            selected={selected_pod === pod.pod}
            icon={selected_pod === pod.pod && 'check'}
            content="Select"
            mt={spods && spods.length ? '2rem' : '0.5rem'}
            onClick={() =>
              act('selectpod', {
                ref: pod.pod,
              })
            }
          />
        );
      }

      return (
        <Box key={i} width="64px" textAlign="center" display="inline-block" mr="0.5rem">
          <img
            src={'pod_' + pod.status + '.gif'}
            style={{
              width: '100%',
              '-ms-interpolation-mode': 'nearest-neighbor',
            }}
          />
          <Box color="label">{pod.name}</Box>
          <Box bold color={pod.biomass >= 150 ? 'good' : 'bad'} inline>
            <Icon name={pod.biomass >= 150 ? 'circle' : 'circle-o'} />
            &nbsp;
            {pod.biomass}
          </Box>
          {podAction}
        </Box>
      );
    });
  }

  return null;
};

const GeneticsCloneConsoleTemp = (props, context) => {
  const { act, data } = useBackend(context);
  const { temp } = data;
  if (!temp || !temp.text || temp.text.length <= 0) {
    return;
  }

  const tempProp = { [temp.style]: true };
  return (
    <NoticeBox {...tempProp}>
      <Box display="inline-block" verticalAlign="middle">
        {temp.text}
      </Box>
      <Button icon="times-circle" float="right" onClick={() => act('cleartemp')} />
      <Box clear="both" />
    </NoticeBox>
  );
};

const GeneticsCloneConsoleStatus = (props, context) => {
  const { act, data } = useBackend(context);
  const { pods, autoallowed, autoprocess, disk } = data;
  return (
    <Section title="Status">
      <LabeledList>
        <LabeledList.Item label="Pods">
          {pods && pods.length ? (
            <Box color="good">{pods.length} connected</Box>
          ) : (
            <Box color="bad">None connected!</Box>
          )}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
